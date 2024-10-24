function openFeaturePopup(){
    window.open(
        "/projects/features/register",
        "기능등록",
        "width=810, height=620, resizable=yes"
    );
}

$(document).ready(function (){
    $(".circle").circleProgress({      //들어갈 div class명을 넣어주세요
        value: 0.9,    //진행된 수를 넣어주세요. 1이 100기준입니다.
        size: 260,       //도넛의 크기를 결정해줍니다.
        fill: {
            gradient: ["#3b82f6", "#f59e0b"]    //도넛의 색을 결정해줍니다.
        }
    }).on('circle-animation-progress', function(event, progress) {    //라벨을 넣어줍니다.
            $(this).find('strong').html(parseInt(100 * 0.9) + '<i>%</i>');
    });

    // var ctx = document.getElementById('systemProgressChart').getContext('2d');
    // var myDoughnutChart = new Chart(ctx, {
    //     type: 'doughnut',
    //     data: {
    //         labels: ['A 시스템', 'B 시스템', 'C 시스템'],
    //         datasets: [{
    //             label: '진척도',
    //             data: [20, 70, 85], // 이 부분에 각 시스템의 진척도 데이터를 입력
    //             backgroundColor: [
    //                 'rgba(255, 99, 132, 0.5)',
    //                 'rgba(54, 162, 235, 0.5)',
    //                 'rgba(255, 206, 86, 0.5)'
    //             ],
    //             borderColor: [
    //                 'rgba(255, 99, 132, 1)',
    //                 'rgba(54, 162, 235, 1)',
    //                 'rgba(255, 206, 86, 1)'
    //             ],
    //             borderWidth: 1
    //         }]
    //     },
    //     options: {
    //         responsive: true,
    //         plugins: {
    //             legend: {
    //                 position: 'top',
    //             },
    //             tooltip: {
    //                 enabled: true,
    //                 callbacks: {
    //                     label: function(tooltipItem) {
    //                         return tooltipItem.label + ': ' + tooltipItem.raw + '%';
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // });

    document.getElementById('toggle-btn').click();

    $(document).on('click', '.feat-info-row', function() {
        $(this).siblings().removeClass("on");
        $(this).addClass("on");
    });

    initGrid();

    getProgressSummary();
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

function getProgressSummary(){
    $.ajax({
        url: '/projects/features/progress?systemNo=1&featClassCd=PMS01001',
        type: 'GET',
        success: function (response) {
          console.log(response);
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
        }
    })
}


function initGrid(){
    var firstGrid = new ax5.ui.grid();

    firstGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "id", label: "기능ID", align: "center", width: 70, formatter: function() {
                    var title = this.value;
                    return '<a href="/projects/issueInfo?title=' + encodeURIComponent(title) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "name", label: "기능명", width: 100, align: "center", formatter: function (){
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
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "A시스템", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "일정관련", priority: "보통", status: "진행", register: "이수호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "일정관련", priority: "보통", status: "완료", register: "이수호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "기타", priority: "긴급", status: "완료", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "기타", priority: "보통", status: "완료", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "기타", priority: "보통", status: "진행", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "기타", priority: "보통", status: "진행", register: "이한희", due_date: "70%", completion_date: "2024-06-12"}
    ];
    firstGrid.setData(gridList);


    var memberGrid = new ax5.ui.grid();

    memberGrid.setConfig({
        target: $('[data-ax5grid="member-grid"]'),
        columns: [
            {key: "memberName", label: "작업자", align: "center", width: 120, formatter: function() {
                    var title = this.value;
                    return '<a href="/projects/issueInfo?title=' + encodeURIComponent(title) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "total", label: "전체건", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "continue", label: "진행건", width: 70, align: "center"},
            {key: "delay", label: "지연건", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px; color: red;">' + this.value + '</span>';
                }},
            {key: "team", label: "소속팀", width: 85, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "progress", label: "진척도", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }}
        ]
    });

    var memberData = [
        {memberName: "홍길동", total: 10, continue: 5, delay: 2, team: "팀1", progress: "50%"},
        {memberName: "이순신", total: 8, continue: 3, delay: 1, team: "팀2", progress: "37.5%"},
        {memberName: "장보고", total: 15, continue: 10, delay: 3, team: "팀1", progress: "66%"},
        {memberName: "유관순", total: 12, continue: 12, delay: 0, team: "팀3", progress: "100%"},
        {memberName: "강감찬", total: 20, continue: 15, delay: 5, team: "팀2", progress: "75%"},
        {memberName: "홍길동", total: 10, continue: 5, delay: 2, team: "팀1", progress: "50%"},
        {memberName: "이순신", total: 8, continue: 3, delay: 1, team: "팀2", progress: "37.5%"},
        {memberName: "장보고", total: 15, continue: 10, delay: 3, team: "팀1", progress: "66%"},
        {memberName: "유관순", total: 12, continue: 12, delay: 0, team: "팀3", progress: "100%"},
        {memberName: "강감찬", total: 20, continue: 15, delay: 5, team: "팀2", progress: "75%"}
    ]

    memberGrid.setData(memberData);




    var delayGrid = new ax5.ui.grid();

    delayGrid.setConfig({
        target: $('[data-ax5grid="delay-grid"]'),
        columns: [
            {key: "id", label: "기능ID", align: "center", width: 70, formatter: function() {
                    var title = this.value;
                    return '<a href="/projects/issueInfo?title=' + encodeURIComponent(title) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "name", label: "기능명", width: 100, align: "center", formatter: function (){
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
        ]
    });

    var delayData = [
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "A시스템", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "A시스템", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
        {id: "1501", name: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "70%", completion_date: "2024-06-12"},
    ]

    delayGrid.setData(delayData);
}