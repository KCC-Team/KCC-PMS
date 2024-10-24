function openFeaturePopup(){
    window.open(
        "/projects/features/register",
        "기능등록",
        "width=810, height=620, resizable=yes"
    );
}

$(document).ready(function (){

    document.getElementById('toggle-btn').click();

    $(document).on('click', '.feat-info-row', function() {
        $(this).siblings().removeClass("on");
        $(this).addClass("on");
    });


    var firstGrid = new ax5.ui.grid();

    firstGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "title", label: "기능ID", align: "center", width: 70, formatter: function() {
                    var title = this.value;
                    return '<a href="/projects/issueInfo?title=' + encodeURIComponent(title) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "type", label: "기능명", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "status", label: "상태", width: 70, align: "center", formatter: function (){
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
            {key: "priority", label: "작업자", width: 70, align: "center" , formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "register", label: "시스템/업무", width: 82, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "due_date", label: "진척도", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }}
        ],
    });

    var gridList = [
        {title: "1501", type: "인력관련", priority: "보통", status: "발생전", register: "A시스템", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "일정관련", priority: "보통", status: "진행", register: "이수호", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "일정관련", priority: "보통", status: "완료", register: "이수호", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "기타", priority: "긴급", status: "완료", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "기타", priority: "보통", status: "완료", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "기타", priority: "보통", status: "진행", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {title: "1501", type: "기타", priority: "보통", status: "진행", register: "이한희", due_date: "70%", completion_date: "2024-06-12"}
    ];
    firstGrid.setData(gridList);

});


document.addEventListener("DOMContentLoaded", function() {
    var progressBars = document.querySelectorAll('.feat-bar');  // 모든 progress 바 선택
    var progressValues = document.querySelectorAll('.prg-val'); // 각 progress에 대한 텍스트 선택

    progressBars.forEach(function(progressBar, index) {
        var value = 0;
        var max = 100;
        var targetValue = parseInt(progressValues[index].textContent); // 해당 progress의 목표 값 추출

        function animateProgress() {
            if (value < targetValue) {
                value++;
                progressBar.value = value;
                progressValues[index].textContent = value + '%';
                setTimeout(animateProgress, 20);
            }
        }

        animateProgress();  // 각 progress 바에 대해 애니메이션 시작
    });
});
