$(function () {
    let testGrid = new ax5.ui.grid();

    testGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "defect_id", label: "결함 ID", align: "center", width: 150, formatter: function() {
                    let item = this.value;
                    return '<input type=hidden name=defect_id value=${item.id} />' +
                        '<a href="/projects/defects/' + encodeURIComponent(item.id) + '" class="defect-id" style="color: #2383f8; font-size: 13px; font-weight: bold; text-decoration: none;">' + item.value + '</a>';
                }},
            {key: "defect_title", label: "결함명", width: 400, align: "center" , formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "order", label: "우선순위", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "defect_status", label: "상태", width: 101, align: "center", formatter: function (){
                    const status = this.value;
                    let statusClass = 'status-label ';

                    if (status === '진행중') {
                        statusClass += 'green-status';
                    } else if (status === '해결') {
                        statusClass += 'blue-status';
                    } else if (status === '취소') {
                        statusClass += 'cancel-status';
                    } else {
                        statusClass += 'red-status';
                    }
                    return '<span class="' + statusClass + '" style="font-size: 12px;">' + this.value + '</span>';
                }
            },
            {key: "discover", label: "발견자", width: 101, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "worker", label: "조치자", width: 101, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "discovered_date", label: "발견일자", width: 130, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "sche_work_date", label: "조치예정일자", width: 130, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "work_date", label: "조치일자", width: 130, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }}
        ],
    });

    let testResponses = [
        {defect_id: {
            value: "TT-AD-01",
            id: 1
            }, defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "신규"},
        {defect_id: "TT-AD-01", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "진행중"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "해결"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "취소"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "취소"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "취소"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "진행중"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "진행중"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "진행중"},
        {defect_id: "UTC_RSTR110", defect_title: "요구사항정의서 ID미부여 항목 발견", order: "상", discover: "박길동", worker: "홍길동", discovered_date: "2024.01.07", sche_work_date: "2024.01.11", work_date: "2024.01.13", defect_status: "진행중"},
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

    $(document).on('click', '.defect-id', function(e) {
        e.preventDefault();
       let popup = window.open($(this).attr('href'), 'popup', 'width=1100, height=677');
    });
});
