package com.kcc.pms.domain.common.service;

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
import java.util.*;

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
    public Long fileUpload(List<MultipartFile> files,
                           Long projectNumber, String fileCode) {
        List<Map<String, Object>> fileList = new ArrayList<>();
        FileMasterVO fileMasterVO = new FileMasterVO(fileCode);
        Integer isSaved = fileMapper.saveFileMaster(fileMasterVO);
        if (isSaved != 1) {
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        }

        try {
            generateFiles(projectNumber, files, fileMasterVO.getFileMasterNumber());
        } catch (Exception e) {
            log.error("파일 업로드 중 오류가 발생했습니다.", e);
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        }

        return fileMasterVO.getFileMasterNumber();
    }

    @Override
    public List<FileResponseDto> getFileList(Long fileMasterNumber) {
        return fileMapper.getFileDetailsRes(fileMasterNumber);
    }

    @Transactional
    @Override
    public void deleteFiles(FileMasterNumbers numbers) {
        deleteFile(numbers.getFileMasterFoundNumber());
        deleteFile(numbers.getFileMasterWorkNumber());
    }

    @Transactional
    @Override
    public void deleteFileDetails(Long fileMasterNumber) {
        int isDeleted = fileMapper.deleteFileDetails(fileMasterNumber);
        if (isDeleted != 1) {
            throw new RuntimeException("파일 삭제 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    @Override
    public void deleteFile(Long number) {
        List<String> filesDetails = fileMapper.findFilesDetails(number);
        awsS3Utils.deleteImages(filesDetails);
        int isDeleted = commonMapper.deleteFileMaster(number);
        if (isDeleted != 1) {
            throw new RuntimeException("파일 삭제 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    @Override
    public void generateFiles(Long projectNumber, List<MultipartFile> files, Long fileMasterNumber) {
        String fileName = UUID.randomUUID().toString();
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        try {
            FileMapper fileMapper = sqlSession.getMapper(FileMapper.class);
            for (MultipartFile file : files) {
                fileMapper.saveFileDetails(file.getOriginalFilename(), file.getContentType(), file.getSize(),
                        fileMasterNumber, "홍길동", awsS3Utils.saveFile(file, projectNumber + "/" + fileName));
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
