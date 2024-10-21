package com.kcc.pms.domain.output.mapper;

import com.kcc.pms.domain.output.domain.vo.FileMasterVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface FileMapper {
    Integer saveFileMaster(FileMasterVO fileMasterVO);
    void saveFileDetails(Map<String, Object> map);
}
