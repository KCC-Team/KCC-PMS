package com.kcc.pms.domain.common.service;

import com.kcc.pms.domain.common.mapper.CommonMapper;
import com.kcc.pms.domain.common.model.dto.CommonCodeSelectListResponseDto;
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
            for (MultipartFile file : files) {
                generateFileMapList(projectNumber, file, fileMasterVO.getFileMasterNumber(), fileList);
            }
            bulkSaveFiles(fileList);
        } catch (Exception e) {
            log.error("파일 업로드 중 오류가 발생했습니다.", e);
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.");
        }

        return fileMasterVO.getFileMasterNumber();
    }

    private void generateFileMapList(Long projectNumber, MultipartFile file, Long fileMasterNumber, List<Map<String, Object>> files) throws IOException {
        Map<String, Object> map = new HashMap<>();
        map.put("originalTitle", file.getOriginalFilename());
        String fileName = UUID.randomUUID().toString();
        map.put("fileType", file.getContentType());
        map.put("fileSize", file.getSize());
        map.put("fileMasterNumber", fileMasterNumber);
        map.put("registerId", "홍길동");
        map.put("filePath", awsS3Utils.saveFile(file, projectNumber + "/" + fileName));
        files.add(map);
    }

    private void bulkSaveFiles(List<Map<String, Object>> files) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        try {
            FileMapper fileMapper = sqlSession.getMapper(FileMapper.class);
            for (Map<String, Object> fileDetail : files) {
                fileMapper.saveFileDetails(fileDetail);
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
}
