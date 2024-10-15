const API_SERVER = 'http://localhost:8085';

$(function () {
    let testGrid = new ax5.ui.grid();

    testGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "testItem", label: "테스트 ID", align: "center", width: 150, formatter: function() {
                    let item = this.value;
                    return '<a href="/projects/tests/' + encodeURIComponent(item.test_no) + '" class="defect-title" style="color: #2383f8; font-size: 13px; font-weight: bold; text-decoration: none;">' + item.test_id + '</a>';
                }},
            {key: "testType", label: "테스트 구분", width: 80, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testTitle", label: "테스트 명", width: 400, align: "center" , formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "workTitle", label: "업무 구분", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testPeriod", label: "테스트 기간", width: 180, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testCaseCount", label: "테스트 케이스", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "defectCount", label: "결함", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testStatus", label: "상태", width: 100, align: "center", formatter: function (){
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

    $.ajax({
        method: "GET",
        url: API_SERVER + "/projects/tests/api/list?sys=0&work=0&test=all&status=all&page=1",
        success: function (res) {
            testGrid.setData(res);
        }, error: function (err) {
            console.error('그리드 데이터 가져오기 오류', err);
        }
    });

    $('.test-add-btn').on('click', function () {
        location.href = '/projects/tests/register';
    });
});