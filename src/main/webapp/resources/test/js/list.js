$(function () {
    let testGrid = new ax5.ui.grid();

    testGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "test_id", label: "테스트 ID", align: "center", width: 200, formatter: function() {
                    let title = this.value;
                    return '<a href="/projects/defects?title=' + encodeURIComponent(title) + '" class="defect-title" style="color: #2383f8; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "test_type", label: "테스트 구분", width: 80, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "test_title", label: "테스트 명", width: 400, align: "center" , formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "class_type", label: "업무 구분", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "test_period", label: "테스트 기간", width: 200, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "case_cnt", label: "결함", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "defect_cnt", label: "결함", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "test_status", label: "상태", width: 100, align: "center", formatter: function (){
                    const status = this.value;

                    let statusClass;
                    if (status === '진행중') {
                        statusClass = 'green-status';
                    } else if (status === '해결') {
                        statusClass = 'blue-status';
                    } else if (status === '취소') {
                        statusClass = 'cancel-status';
                    } else {
                        statusClass = 'red-status';
                    }


                    return '<span class="' + statusClass + '" style="font-size: 12px;">' + this.value + '</span>';
                }}
        ],
    });

    let testResponses = [
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "신규"},
        {test_id: "TT-AD-01", test_type: "통합", test_title: "A 업무시스템 연간감사 통합 테스트", class_type: "연간감사", test_period: "2024.01.02 ~ 2024.01.06", case_cnt: "5", defect_cnt: "0", test_status: "진행중"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "해결"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "취소"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "취소"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "취소"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "진행중"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "진행중"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "진행중"},
        {test_id: "UTC_RSTR110", test_type: "단위", test_title: "열차고장신고등록 단위 테스트", class_type: "차량검수", test_period: "2024.01.07 ~ 2024.01.11", case_cnt: "5", defect_cnt: "1", test_status: "진행중"},
    ];
    testGrid.setData(testResponses);

    // 그리드 데이터 가져오기
    /*
    $.ajax({
        method: "GET",
        url: API_SERVER + "/api/v1/ax5grid",
        success: function (res) {
            firstGrid.setData(res);
        }
    });
    */
});