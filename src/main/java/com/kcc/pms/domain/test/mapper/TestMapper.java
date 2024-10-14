package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.test.domain.dto.TestListVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface TestMapper {
    Optional<List<TestListVO>> findAllByOptions(Map<String, String> parameters);
}
