package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.test.domain.dto.TestListResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface TestMapper {
    Optional<List<TestListResponseDto>> findAllByOptions(Integer systemId, String work_type, String test_type, int page);
}
