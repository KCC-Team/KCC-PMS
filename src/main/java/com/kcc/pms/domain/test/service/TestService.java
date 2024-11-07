package com.kcc.pms.domain.test.service;

import com.aspose.cells.Workbook;
import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestMasterRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public interface TestService {
    List<CommonCodeOptions> getDefectCommonCodeOptions();
    TestPageResponseDto getTestList(Long prj_no, Long work_no, String test_type, String status, String search, int page);
    Long saveTest(Long memberNo, Long prjNo, TestMasterRequestDto testReq, String type);
    Workbook excelDownload(HttpServletResponse response, Long testNo) throws Exception;
    TestMasterRequestDto getTest(Long testNo);
    Long updateTest(TestMasterRequestDto testReq);
    void deleteTest(Long testNo);
    List<FeatureSimpleResponseDto> getFeatures(Long prjNo);
}
