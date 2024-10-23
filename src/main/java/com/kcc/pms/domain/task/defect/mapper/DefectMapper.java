package com.kcc.pms.domain.task.defect.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface DefectMapper {
    Integer saveDefect(Map<String, Object> map);
}
