package com.kcc.pms.domain.common.util;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.risk.model.excel.ExcelFileDetailDto;
import com.kcc.pms.domain.risk.model.excel.ExcelHistoryDto;
import com.kcc.pms.domain.risk.model.excel.ExcelRiskDto;
import org.apache.poi.common.usermodel.HyperlinkType;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@Component
public class ExcelGenerator {
    private final CommonService commonService;

    @Autowired
    public ExcelGenerator(CommonService commonService) {
        this.commonService = commonService;
    }

    public byte[] generateRiskExcel(List<ExcelRiskDto> risks) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Risk Data");

        // 제목 설정
        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("식별 위험 목록");
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 14);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleCell.setCellStyle(titleStyle);

        // 제목 셀 병합 및 테두리 설정
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));


        // 빈 행 추가
        sheet.createRow(1);

        // 헤더 작성 및 각 열 너비 설정
        Row headerRow = sheet.createRow(2);
        String[] headers = {"No", "시스템/업무구분", "영역구분", "예상위험", "예상위험 상세 내용", "해결/완화방안", "완료예정일", "조치내역", "상태", "완료일", "비고"};
        int[] columnWidths = {1500, 4000, 3000, 4000, 10000, 10000, 3000, 10000, 3000, 3000, 3000};

        // 헤더 스타일 설정
        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        headerStyle.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setWrapText(true);
        headerStyle.setBorderTop(BorderStyle.MEDIUM);
        headerStyle.setBorderBottom(BorderStyle.MEDIUM);
        headerStyle.setBorderLeft(BorderStyle.MEDIUM);
        headerStyle.setBorderRight(BorderStyle.MEDIUM);

        // 헤더 설정 및 병합된 셀 테두리 적용
        for (int i = 0; i < headers.length; i++) {
            Cell headerCell = headerRow.createCell(i);
            headerCell.setCellValue(headers[i]);
            headerCell.setCellStyle(headerStyle);
            sheet.setColumnWidth(i, columnWidths[i]);
            sheet.addMergedRegion(new CellRangeAddress(2, 3, i, i)); // 병합
        }

        sheet.createFreezePane(0, 4);

        // 데이터 셀 스타일 설정
        CellStyle dataCellStyle = workbook.createCellStyle();
        dataCellStyle.setWrapText(true);
        dataCellStyle.setBorderTop(BorderStyle.MEDIUM);
        dataCellStyle.setBorderBottom(BorderStyle.MEDIUM);
        dataCellStyle.setBorderLeft(BorderStyle.MEDIUM);
        dataCellStyle.setBorderRight(BorderStyle.MEDIUM);
        dataCellStyle.setAlignment(HorizontalAlignment.JUSTIFY);
        dataCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        int rowNum = 3; // 데이터 시작 행 설정

        // 데이터 추가
        for (ExcelRiskDto risk : risks) {
            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(rowNum - 4); // No 칼럼
            row.createCell(1).setCellValue(risk.getSysTtl());
            row.createCell(2).setCellValue(risk.getClassCd().trim());
            row.createCell(3).setCellValue(risk.getRskTtl());
            row.createCell(4).setCellValue(risk.getRiskCont());
            row.createCell(5).setCellValue(risk.getRiskPlan());
            row.createCell(6).setCellValue(risk.getDueDt() != null ? dateFormat.format(risk.getDueDt()) : "");

            // 조치 이력과 첨부파일 처리
            StringBuilder historyContent = new StringBuilder();
            int historyRow = 0;
            for (ExcelHistoryDto history : risk.getHistories()) {
                historyRow++;
                historyContent.append(historyRow).append(". ")
                        .append(history.getRecordCont()).append(" (")
                        .append(dateFormat.format(history.getRecordDt())).append(") - ")
                        .append(history.getMemNm());

                if (!history.getHistoryFiles().isEmpty()) {
                    historyContent.append("\n첨부파일: ");
                    for (ExcelFileDetailDto file : history.getHistoryFiles()) {
                        historyContent.append(file.getOriginalTtl()).append("; ");
                    }
                    historyContent.setLength(historyContent.length() - 2); // 마지막 쉼표 제거
                }
                historyContent.append("\n\n");
            }

            Cell historyCell = row.createCell(7);
            historyCell.setCellValue(historyContent.toString());
            historyCell.setCellStyle(dataCellStyle);

            row.createCell(8).setCellValue(risk.getStatCd().trim());
            row.createCell(9).setCellValue(risk.getComplDt() != null ? dateFormat.format(risk.getComplDt()) : "");

            StringBuilder findFilesContent = new StringBuilder();
            for (ExcelFileDetailDto file : risk.getFindFiles()) {
                findFilesContent.append(file.getOriginalTtl()).append("\n"); // 원본 파일명만 출력하고 줄바꿈 추가
            }

            Cell findFilesCell = row.createCell(10);
            findFilesCell.setCellValue(findFilesContent.toString());
            findFilesCell.setCellStyle(dataCellStyle);

            // 각 데이터 셀에 스타일 적용
            for (int i = 0; i <= 10; i++) {
                row.getCell(i).setCellStyle(dataCellStyle);
            }

            row.setHeight((short) -1);
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray();
    }


}
