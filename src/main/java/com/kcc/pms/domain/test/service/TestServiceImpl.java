package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.mapper.FeatureMapper;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.system.mapper.SystemMapper;
import com.kcc.pms.domain.test.domain.dto.*;
import com.kcc.pms.domain.test.mapper.TestMapper;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xddf.usermodel.chart.*;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {
    private final TestMapper testMapper;
    private final SystemMapper systemMapper;
    private final FeatureMapper featureMapper;

    private final static int LIMIT = 15;

    @Override
    public List<CommonCodeOptions> getDefectCommonCodeOptions() {
        return testMapper.getCommonCodeOptions();
    }

    @Override
    public TestPageResponseDto getTestList(Long projectNumber, Long workNumber, String testType, String status, String search, int page) {
        TestPageResponseDto tests = testMapper.findAllByOptions(projectNumber, workNumber, testType, status, search, page, LIMIT);
        tests.setTotalPage((int) Math.ceil((double) tests.getTotalElements() / LIMIT));
        return tests;
    }

    @Transactional
    @Override
    public Long saveTest(Long memberNo, Long projectNo, TestMasterRequestDto testReq, String type) {
        if (Objects.equals(type, "n")) {
            testMapper.saveTest(memberNo, projectNo, testReq);

            for (TestDetailRequestDto testDetail : testReq.getTestCaseList()) {
                if ("PMS01201".equals(testReq.getTestType())) {
                    saveUnitTestDetails(testReq.getTestNumber(), testDetail);
                    testMapper.deleteFeatureTests(testDetail.getTestDetailNumber());
                    testMapper.saveFeatureTest(testDetail.getFeatNumbers().get(0), testDetail.getTestDetailNumber());
                } else if ("PMS01202".equals(testReq.getTestType())) {
                    testMapper.saveIntegrationTestDetails(testReq.getTestNumber(), testDetail.getTestDetailId(), testDetail);
                    saveIntegrationTestDetails(testReq.getTestNumber(), testDetail);
                }

            }
        } else {
            testMapper.saveTest(memberNo, projectNo, testReq);
        }

        return testReq.getTestNumber();
    }

    @Override
    public void excelDownload(HttpServletResponse response, Long testNo) throws Exception {
        TestMasterRequestDto test = getTest(testNo);

        if (Objects.equals(test.getTestType(), "PMS01201")) {
            excelDownloadUnitTest(response, test);
        } else {
            // Handle other test types if necessary
        }
    }

    @Override
    public TestMasterRequestDto getTest(Long testNo) {
        String testType = testMapper.getTestType(testNo);
        if (Objects.equals(testType, "PMS01201")) {
            return testMapper.getTest(testNo).orElseThrow(() -> new IllegalArgumentException("해당 테스트가 존재하지 않습니다."));
        } else {
            TestMasterRequestDto testMasterRequestDto = testMapper.getIntegrationTest(testNo).orElseThrow(() -> new IllegalArgumentException("해당 테스트가 존재하지 않습니다."));

            List<TestDetailRequestDto> details = new ArrayList<>();
            int idx = -1;
            int detailIdx = -1;
            for (TestDetailRequestDto req : testMasterRequestDto.getTestCaseList()) {
                if (req.getPreCondition() != null) {
                    idx++;
                    req.setTests(new ArrayList<>());
                    req.setTestCaseDetails(new ArrayList<>());
                    details.add(req);
                } else if (req.getTestData() != null) {
                    details.get(idx).getTestCaseDetails().add(new TestDetailRequestDto());
                    detailIdx++;
                    details.get(idx).getTestCaseDetails().get(detailIdx).setTestDetailNumber(req.getTestDetailNumber());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWorkContent(req.getWorkContent());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setTestData(req.getTestData());
                    if (!req.getFeatNumbers().isEmpty()) {
                        details.get(idx).getTestCaseDetails().get(detailIdx).setFeatNumbers(req.getFeatNumbers());
                    }
                    details.get(idx).getTestCaseDetails().get(detailIdx).setEstimatedResult(req.getEstimatedResult());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWrittenDate(req.getWrittenDate());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWriterNo(req.getWriterNo());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWriterName(req.getWriterName());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setTestDate(req.getTestDate());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setResult(req.getResult());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setDefectNos(req.getDefectNos());
                } else if (req.getTestDetailContent() != null) {
                    if (details.get(idx).getTestCaseDetails().get(detailIdx).getTests() == null) {
                        details.get(idx).getTestCaseDetails().get(detailIdx).setTests(new ArrayList<>());
                    }
                    details.get(idx).getTestCaseDetails().get(detailIdx).getTests().add(
                            new TestRequestDto(req.getTestDetailNumber(), req.getTestDetailId(), req.getTestDetailContent())
                    );
                }
            }
            testMasterRequestDto.setTestCaseList(details);
            return  testMasterRequestDto;
        }
    }

    @Transactional
    @Override
    public Long updateTest(TestMasterRequestDto testReq) {
        String testType = testMapper.getTestType(testReq.getTestNumber());
        testMapper.updateTest(testReq);

        for (TestDetailRequestDto testDetail : testReq.getTestCaseList()) {
            if (Objects.equals(testType, "PMS01201")) {
                if (testDetail.getFeatNumbers() != null) {
                    if (testDetail.getTestDetailNumber() == null) {
                        saveUnitTestDetails(testReq.getTestNumber(), testDetail);
                    }
                    testMapper.deleteFeatureTests(testDetail.getTestDetailNumber());
                    for (Long featNumber : testDetail.getFeatNumbers()) {
                        testMapper.saveFeatureTest(featNumber, testDetail.getTestDetailNumber());
                    }
                }

                if (testReq.getTestCaseList() != null) {
                    testMapper.updateTestDetail(testDetail);
                } else {
                    testMapper.saveUnitTestDetails(testReq.getTestNumber(), testDetail);
                }

                if (testDetail.getTests() != null) {
                    for (TestRequestDto test : testDetail.getTests()) {
                        testMapper.updateTestStage(test);
                    }
                }
            } else {
                if (testDetail.getTestDetailNumber() == null) {
                    testMapper.saveIntegrationTestDetails(testReq.getTestNumber(), testDetail.getTestDetailId(), testDetail);
                } else {
                    testMapper.updateIntegrationTestDetails(testReq.getTestNumber(), testDetail);
                }
                updateIntegrationTestDetails(testReq.getTestNumber(), testDetail);
            }
        }

        return testReq.getTestNumber();
    }

    @Transactional
    @Override
    public void deleteTest(Long testNo) {
        testMapper.deleteTest(testNo);
    }

    @Override
    public List<FeatureSimpleResponseDto> getFeatures(Long projectNo) {
        return testMapper.getFeatures(projectNo);
    }

    private void saveUnitTestDetails(Long testNo, TestDetailRequestDto testCase) {
        testMapper.saveUnitTestDetails(testNo, testCase);
    }

    private void saveIntegrationTestDetails(Long testNo, TestDetailRequestDto testCase) {
        for (TestDetailRequestDto testDetail : testCase.getTestCaseDetails()) {
            testMapper.saveTestDetails(testNo, testDetail, testCase.getTestDetailNumber());

            for (Long featNumber : testDetail.getFeatNumbers()) {
                testMapper.saveFeatureTest(featNumber, testDetail.getTestDetailNumber());
            }
            for (TestRequestDto test : testDetail.getTests()) {
                testMapper.saveTestStage(testDetail.getTestDetailNumber(), testNo, test);
            }
        }
    }

    private void updateIntegrationTestDetails(Long testNo, TestDetailRequestDto testCase) {
        for (TestDetailRequestDto testDetail : testCase.getTestCaseDetails()) {
            if (testDetail.getTestDetailNumber() != null) {
                testMapper.updateTestDetail(testDetail);
            } else {
                testMapper.saveTestDetails(testNo, testDetail, testCase.getTestDetailNumber());
            }

            testMapper.deleteFeatureTests(testDetail.getTestDetailNumber());
            for (Long featNumber : testDetail.getFeatNumbers()) {
                testMapper.saveFeatureTest(featNumber, testDetail.getTestDetailNumber());
            }

            testMapper.deleteTestStage(testDetail.getTestDetailNumber());
            for (TestRequestDto test : testDetail.getTests()) {
                testMapper.saveTestStage(testDetail.getTestDetailNumber(), testNo, test);
            }
        }
    }

    private void excelDownloadUnitTest(HttpServletResponse response, TestMasterRequestDto test) throws Exception {
        int passCount = 0;
        int failCount = 0;

        InputStream inputStream = new FileInputStream("src/main/resources/templates/unitTest.xlsx");
        Workbook workbook = WorkbookFactory.create(inputStream);
        Sheet sheet = workbook.getSheetAt(0);

        CellStyle borderStyle = workbook.createCellStyle();
        borderStyle.setAlignment(HorizontalAlignment.LEFT);
        borderStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        borderStyle.setBorderTop(BorderStyle.THIN);
        borderStyle.setBorderBottom(BorderStyle.THIN);
        borderStyle.setBorderLeft(BorderStyle.THIN);
        borderStyle.setBorderRight(BorderStyle.THIN);
        borderStyle.setDataFormat(workbook.createDataFormat().getFormat("yyyy-MM-dd"));

        CellStyle centerStyle = workbook.createCellStyle();
        centerStyle.setAlignment(HorizontalAlignment.CENTER);
        centerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        centerStyle.setBorderTop(BorderStyle.THIN);
        centerStyle.setBorderBottom(BorderStyle.THIN);
        centerStyle.setBorderLeft(BorderStyle.THIN);
        centerStyle.setBorderRight(BorderStyle.THIN);

        Row row = sheet.getRow(3);
        Cell cell = row.getCell(4);
        if (cell == null) {
            cell = row.createCell(4);
        }
        cell.setCellValue(test.getTestTitle());
        cell.setCellStyle(borderStyle);
        cell = row.getCell(13);
        if (cell == null) {
            cell = row.createCell(13);
        }
        if (test.getTestType().equals("PMS01201")) {
            cell.setCellValue("단위 테스트");
        } else {
            cell.setCellValue("통합 테스트");
        }
        cell.setCellStyle(borderStyle);
        row = sheet.getRow(4);
        cell = row.getCell(4);
        if (cell == null) {
            cell = row.createCell(4);
        }
        cell.setCellValue(test.getTestId());
        cell.setCellStyle(borderStyle);
        cell = row.getCell(13);
        if (cell == null) {
            cell = row.createCell(13);
        }
        cell.setCellValue(systemMapper.getSystemName(test.getWorkSystemNo()));
        cell.setCellStyle(borderStyle);
        row = sheet.getRow(5);
        cell = row.getCell(4);
        if (cell == null) {
            cell = row.createCell(4);
        }
        cell.setCellValue(test.getTestStartDate());
        cell.setCellStyle(borderStyle);
        cell = row.getCell(13);
        if (cell == null) {
            cell = row.createCell(13);
        }
        cell.setCellValue(test.getTestEndDate());
        cell.setCellStyle(borderStyle);
        row = sheet.getRow(6);
        cell = row.getCell(4);
        if (cell == null) {
            cell = row.createCell(4);
        }
        cell.setCellValue(test.getTestContent());
        cell.setCellStyle(borderStyle);
        row = sheet.getRow(8);
        cell = row.getCell(4);
        if (cell == null) {
            cell = row.createCell(4);
        }
        cell.setCellValue(test.getTestCaseList().get(0).getTestDetailId());
        cell.setCellStyle(borderStyle);

        row = sheet.getRow(8);
        cell = row.getCell(13);
        if (cell == null) {
            cell = row.createCell(13);
        }
        cell.setCellValue(featureMapper.getFeatureDetail(test.getTestCaseList().get(0).getFeatNumbers().get(0)).getFeatTitle());
        cell.setCellStyle(borderStyle);
        int startRow = 12;
        int chartDataStartRow = 17;
        for (int i = 0; i < test.getTestCaseList().size(); i++) {
            TestDetailRequestDto testCase = test.getTestCaseList().get(i);
            row = sheet.getRow(startRow + i);
            if (row == null) {
                row = sheet.createRow(startRow + i);
            }
            cell = row.getCell(0);
            if (cell == null) {
                cell = row.createCell(0);
            }
            cell.setCellValue((i+1));
            cell.setCellStyle(centerStyle);
            mergeCellsAndSetValue(sheet, startRow + i, "B", "D", testCase.getPreCondition(), "y");
            mergeCellsAndSetValue(sheet, startRow + i, "E", "G", testCase.getTestDetailContent(), "y");
            mergeCellsAndSetValue(sheet, startRow + i, "H", "J", testCase.getTestProcedure(), "y");
            mergeCellsAndSetValue(sheet, startRow + i, "K", "M", testCase.getEstimatedResult(), "y");
            mergeCellsAndSetValue(sheet, startRow + i, "N", "O", testCase.getWrittenDate(), null);
            cell = row.getCell(15);
            if (cell == null) {
                cell = row.createCell(15);
            }
            cell.setCellValue(testCase.getWriterName());
            cell.setCellStyle(centerStyle);
            cell = row.getCell(16);
            if (cell == null) {
                cell = row.createCell(16);
            }
            cell.setCellValue(testCase.getTestDate());
            cell.setCellStyle(centerStyle);
            cell = row.getCell(chartDataStartRow);
            if (cell == null) {
                cell = row.createCell(chartDataStartRow);
            }
            if (Objects.equals(testCase.getResult(), "PMS01401")) {
                cell.setCellValue("PASS");
                passCount++;
            } else {
                cell.setCellValue("결함 발생");
                failCount++;
            }
            cell.setCellStyle(centerStyle);
            cell = row.getCell(18);
            if (cell == null) {
                cell = row.createCell(18);
            }
            for (TestDefectDto defectNo : testCase.getDefectNos()) {
                cell.setCellValue(defectNo.getDefectId() != null ? defectNo.getDefectId() : "-");
            }
            cell.setCellStyle(centerStyle);

        }
        row = sheet.getRow(0);
        if (row == null) {
            row = sheet.createRow(0);
        }
        Cell dataCell_1 = row.createCell(chartDataStartRow);
        dataCell_1.setCellValue("결과");
        dataCell_1.setCellStyle(borderStyle);
        Cell dataCell_2 = row.createCell(chartDataStartRow + 1);
        dataCell_2.setCellValue("개수");
        dataCell_2.setCellStyle(borderStyle);
        Row dataRow2 = sheet.createRow(1);
        dataRow2.createCell(chartDataStartRow).setCellValue("PASS");
        Cell cell1 = dataRow2.createCell(chartDataStartRow + 1);
        cell1.setCellValue(passCount);
        cell1.setCellStyle(centerStyle);

        Row dataRow3 = sheet.createRow(2);
        dataRow3.createCell(chartDataStartRow).setCellValue("결함 발생");
        Cell cell2 = dataRow3.createCell(chartDataStartRow + 1);
        cell2.setCellValue(failCount);
        cell2.setCellStyle(centerStyle);

        // 드로잉 패트리아트 생성
        XSSFDrawing drawing = (XSSFDrawing) sheet.createDrawingPatriarch();
        XSSFClientAnchor anchor = drawing.createAnchor(0, 0, 0, 0, 0, 10, 15, 25);
        anchor.setCol1(19); // 차트 시작 열
        anchor.setRow1(0); // 차트 시작 행
        anchor.setCol2(23); // 차트 끝 열
        anchor.setRow2(9); // 차트 끝 행

        XSSFChart chart = drawing.createChart(anchor);

        XDDFChartLegend legend = chart.getOrAddLegend();
        legend.setPosition(LegendPosition.TOP_RIGHT);
        XDDFDataSource<String> xs = XDDFDataSourcesFactory.fromStringCellRange((XSSFSheet) sheet,
                new CellRangeAddress(1, 2, 17, 17));
        XDDFNumericalDataSource<Double> ys = XDDFDataSourcesFactory.fromNumericCellRange((XSSFSheet) sheet,
                new CellRangeAddress(1, 2 , 18, 18));

        XDDFPieChartData pieChartData = (XDDFPieChartData) chart.createData(ChartTypes.PIE, null, null);

        XDDFPieChartData.Series series = (XDDFPieChartData.Series) pieChartData.addSeries(xs, ys);
        series.setTitle("테스트 결과", null);
        chart.plot(pieChartData);
        chart.setTitleText("테스트 결과 분포");
        chart.setTitleOverlay(false);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String fileName = "unitTest_" + test.getTestTitle() + ".xlsx";
        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
        workbook.close();
        inputStream.close();
    }

    private void mergeCellsAndSetValue(Sheet sheet, int rowNumber, String startColumn, String endColumn, String value, String type) {
        int startColIndex = columnNameToIndex(startColumn);
        int endColIndex = columnNameToIndex(endColumn);

        CellRangeAddress region = new CellRangeAddress(rowNumber, rowNumber, startColIndex, endColIndex);
        sheet.addMergedRegion(region);

        Row row = sheet.getRow(rowNumber);
        if (row == null) {
            row = sheet.createRow(rowNumber);
        }

        CellStyle style = sheet.getWorkbook().createCellStyle();
        if (type != null) {
            style.setAlignment(HorizontalAlignment.LEFT);
        } else {
            style.setAlignment(HorizontalAlignment.CENTER);
        }
        style.setAlignment(HorizontalAlignment.LEFT);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);

        for (int colIdx = startColIndex; colIdx <= endColIndex; colIdx++) {
            Cell cell = row.createCell(colIdx);
            cell.setCellStyle(style);
            if (colIdx == startColIndex) {
                cell.setCellValue(value);
            }
        }
    }

    private int columnNameToIndex(String columnName) {
        int columnIndex = 0;
        for (int i = 0; i < columnName.length(); i++) {
            char c = columnName.charAt(i);
            columnIndex *= 26;
            columnIndex += c - 'A' + 1;
        }
        return columnIndex - 1;
    }
}
