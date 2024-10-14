$(document.body).ready(function () {
    var firstGrid = new ax5.ui.grid();

    firstGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "title", label: "위험명", align: "center", width: 274, formatter: function() {
                    var title = this.value;
                    return '<a href="/projects/dangerInfo?title=' + encodeURIComponent(title) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "type", label: "위험구분", width: 150, align: "center", formatter: function (){
                return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "priority", label: "우선순위", width: 100, align: "center" , formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "status", label: "상태", width: 100, align: "center", formatter: function (){
                var status = this.value;
                var statusClass = 'status-label ';  // 기본 클래스

                    if (status === '진행') {
                        console.log('즉시찾음');
                        statusClass += 'status-in-progress';  // 위험일 경우
                    } else if (status === '발생전') {
                        statusClass += 'status-before';  // 진행 중일 경우
                    } else if (status === '완료') {
                        statusClass += 'status-completed';  // 완료일 경우
                    }

                    return '<span class="' + statusClass + '" style="font-size: 13px;">' + status + '</span>';
                }},
            {key: "register", label: "등록자", width: 130, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "due_date", label: "조치희망일", width: 130, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "completion_date", label: "조치완료일", width: 130, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }}
        ],

    });

    var gridList = [
        {title: "위험제목", type: "인력관련", priority: "보통", status: "발생전", register: "이수호", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "일정관련", priority: "보통", status: "진행", register: "이수호", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "일정관련", priority: "보통", status: "완료", register: "이수호", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "기타", priority: "긴급", status: "완료", register: "김연호", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "기타", priority: "보통", status: "완료", register: "이한희", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "기타", priority: "보통", status: "진행", register: "이한희", due_date: "2024-06-12", completion_date: "2024-06-12"},
        {title: "위험제목", type: "기타", priority: "보통", status: "진행", register: "이한희", due_date: "2024-06-12", completion_date: "2024-06-12"}
    ];
    firstGrid.setData(gridList);

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