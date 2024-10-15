package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.test.domain.dto.TestVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TestMapper {
    List<TestVO> findAllByOptions(Map<String, Object> parameters);
}
