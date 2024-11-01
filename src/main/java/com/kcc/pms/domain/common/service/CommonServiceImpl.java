package com.kcc.pms.domain.common.service;

import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.util.IOUtils;
import com.kcc.pms.domain.common.mapper.CommonMapper;
import com.kcc.pms.domain.common.model.dto.CommonCodeSelectListResponseDto;
import com.kcc.pms.domain.common.model.dto.FileResponseDto;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.util.AwsS3Utils;
import com.kcc.pms.domain.output.domain.vo.FileMasterVO;
import com.kcc.pms.domain.output.mapper.FileMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CommonServiceImpl implements CommonService {
    private final SqlSessionFactory sqlSessionFactory;
    private final AwsS3Utils awsS3Utils;

    private final CommonMapper commonMapper;
    private final FileMapper fileMapper;

    @Override
    public List<CommonCodeSelectListResponseDto> getCommonCodeSelectList(String commonCodeNo) {
         return commonMapper.getCommonCodeList(commonCodeNo);
    }

    @Transactional
    @Override
    public Long fileUpload(List<MultipartFile> files, String memberName,
                           Long projectNumber, String fileCode) {
        FileMasterVO fileMasterVO = new FileMasterVO(fileCode);
        Integer isSaved = fileMapper.saveFileMaster(fileMasterVO);
        if (isSaved != 1) {
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        }

        try {
            generateFiles(projectNumber, memberName, files, fileMasterVO.getFileMasterNumber());
        } catch (Exception e) {
            log.error("파일 업로드 중 오류가 발생했습니다.", e);
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        }

        return fileMasterVO.getFileMasterNumber();
    }

    @Transactional
    @Override
    public Long fileUploadToOutput(List<MultipartFile> files, String memberName, Long projectNumber, Long outputNumber) {
        Long fileMasterNumber = fileMapper.findFileMasterNumber(outputNumber);

        try {
            generateFiles(projectNumber, memberName, files, fileMasterNumber);
        } catch (Exception e) {
            log.error("파일 업로드 중 오류가 발생했습니다.", e);
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        }

        return fileMasterNumber;
    }

    @Override
    public List<FileResponseDto> getFileList(Long fileMasterNumber) {
        return fileMapper.getFileDetailsRes(fileMasterNumber);
    }

    @Transactional
    @Override
    public void deleteFiles(FileMasterNumbers numbers) {
        if (numbers.getFileMasterFoundNumber() != null) {
            deleteFile(numbers.getFileMasterFoundNumber());
        }
        if (numbers.getFileMasterWorkNumber() != null) {
            deleteFile(numbers.getFileMasterWorkNumber());
        }
    }

    @Transactional
    @Override
    public void deleteFileDetails(String deleteName, Long fileMasterNumber) {
        int isDeleted = fileMapper.deleteFileDetails(deleteName, fileMasterNumber);
        if (isDeleted != 1) {
            throw new RuntimeException("파일 삭제 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    @Override
    public void deleteFile(Long number) {
        List<String> filesDetails = fileMapper.findFilesDetails(number);
        awsS3Utils.deleteImages(filesDetails);
        fileMapper.deleteFileMaster(number);
    }

    @Override
    public void deleteFileDetail(String deleteName, Long fileDetailNumber) {
        String filePath = fileMapper.findFileDetailTitle(fileDetailNumber);
        awsS3Utils.deleteImage(filePath);
        int isDeleted = fileMapper.deleteFileDetail(deleteName, fileDetailNumber);
        if (isDeleted != 1) {
            throw new RuntimeException("파일 삭제 중 오류가 발생했습니다.");
        }
    }

    @Override
    public byte[] downloadFile(String filePath) throws IOException {
        S3ObjectInputStream s3ObjectInputStream = awsS3Utils.downloadFile(filePath);
        byte[] bytes = IOUtils.toByteArray(s3ObjectInputStream);
        s3ObjectInputStream.close();
        return bytes;
    }

    @Transactional
    @Override
    public void generateFiles(Long projectNumber, String memberName, List<MultipartFile> files, Long fileMasterNumber) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        try {
            FileMapper fileMapper = sqlSession.getMapper(FileMapper.class);
            for (MultipartFile file : files) {
                fileMapper.saveFileDetails(file.getOriginalFilename(), file.getContentType(), file.getSize(),
                        fileMasterNumber, memberName, awsS3Utils.saveFile(file, projectNumber + "/" + UUID.randomUUID()));
            }
            sqlSession.flushStatements();
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        } finally {
            sqlSession.close();
        }
    }

    private void bulkSaveFiles(Map<String, Object> file) {
    }
}
