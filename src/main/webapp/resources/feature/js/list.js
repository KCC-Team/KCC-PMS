var firstGrid;
function openFeaturePopup(){
    window.open(
        "/projects/features/register",
        "기능등록",
        "width=810, height=620, resizable=yes"
    );
}

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('toggle-btn').click();
});


$(document).ready(function (){

    // toggle-btn 클릭 후 실행되는 작업들
    $(".circle").circleProgress({ //들어갈 div class명을 넣어주세요
        value: 0.9,    //진행된 수를 넣어주세요. 1이 100기준입니다.
        size: 260,       //도넛의 크기를 결정해줍니다.
        fill: {
            gradient: ["#3b82f6", "#f59e0b"]    //도넛의 색을 결정해줍니다.
        }
    }).on('circle-animation-progress', function(event, progress) {    //라벨을 넣어줍니다.
        $(this).find('strong').html(parseInt(100 * 0.9) + '<i>%</i>');
    });

    $(document).on('click', '.feat-info-row', function() {
        $(this).siblings().removeClass("on");
        $(this).addClass("on");
    });

    getFeatureClassCommonCode();

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");

    setTimeout(function() {
        initGrid();
    }, 200); // 100ms 지연 후 표시

    getProgressSummary();


});


document.addEventListener("DOMContentLoaded", function() {
    var progressBars = document.querySelectorAll('.feat-bar');  // 모든 progress 바 선택
    var progressValues = document.querySelectorAll('.prg-val'); // 각 progress에 대한 텍스트 선택

    progressBars.forEach(function(progressBar, index) {
        var targetValue = parseInt(progressValues[index].textContent);
        animateProgressBar(progressBar, targetValue);
    });
});

function getProgressSummary(systemNo, featClassCd){
    featClassCd = $('#featClassOption').val();
    console.log("ajax 요청할 systemNo = " + systemNo)
    console.log("ajax 요청할 featClassCd = " + featClassCd)

    $.ajax({
        url:'/projects/features/list?systemNo=' + systemNo + '&featClassCd=' + featClassCd,
        type: 'GET',
        success: function (response){
            console.log("기능 목록 :", response);
            firstGrid.setData(response);
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
        }
    })

    $.ajax({
        url: '/projects/features/progress?systemNo=' + systemNo + '&featClassCd=' + featClassCd,
        type: 'GET',
        success: function (response) {
          console.log(response);

            $("#midSystemFeatureTitle").text(
                $('#system-select span:first-child').text() +
                ($('#featClassOption').val() ? " > " + $('#featClassOption option:selected').text() : "")
            );


          $("#midFeatBar").attr("value", response.progress);
          if (response.progress == null || isNaN(response.progress)) {
              $("#midFPrgVal").text("0%");
          } else {
              $("#midFPrgVal").text(response.progress + "%");
          }


          var midbar = $("#midFeatBar")[0];
          animateProgressBar(midbar, response.progress);

          $("#midTotalCnt").text(response.total);
          $("#midCompleteCnt").text(response.complete);
          $("#midContinueCnt").text(response.presentCount);
          $("#midDelayCnt").text(response.delay);
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
        }
    })
}


function initGrid(){
    firstGrid = new ax5.ui.grid();

    firstGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        columns: [
            {key: "featureId", label: "기능ID", align: "center", width: 70, formatter: function() {
                    var title = this.value;
                    return '<a href="/projects/issueInfo?title=' + encodeURIComponent(title) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                }},
            {key: "featureTitle", label: "기능명", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "status", label: "상태", width: 70, align: "center", formatter: function (){
                    var status = this.value.trim();
                    var statusClass = 'status-label ';  // 기본 클래스

                    if (status === '신규') {
                        statusClass += 'status-in-progress';  // 위험일 경우
                    } else if (status === '개발중') {
                        statusClass += 'status-before';  // 진행 중일 경우
                    } else if (status === '고객확인') {
                        statusClass += 'status-completed';  // 완료일 경우
                    }

                    return '<span class="' + statusClass + '" style="font-size: 13px;">' + status + '</span>';
                }},
            {key: "memberName", label: "작업자", width: 70, align: "center" , formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "system", label: "시스템/업무", width: 82, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "progress", label: "진척도", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "remainingDays", label: "남은일수", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }}
        ]
    });


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
            {key: "team", label: "소속팀", width: 128, align: "center", formatter: function (){
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
            {key: "register", label: "시스템/업무", width: 83, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "due_date", label: "진척도", width: 68, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "delaydays", label: "지연일수", width: 70, align: "center", formatter: function (){
                    return '<span style="font-size: 13px; color: red;">' + this.value + '</span>';
                }}
        ]
    });

    var delayData = [
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "A시스템", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "A시스템", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "인력관련", priority: "보통", status: "발생전", register: "이한희", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "인력관련", priority: "긴급", status: "발생전", register: "김연호", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
        {id: "1501", name: "일정관련", priority: "즉시", status: "진행", register: "김연호", due_date: "70%", completion_date: "2024-06-12", delaydays:3},
    ]

    delayGrid.setData(delayData);
}


function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("systems: " + response);
            return response;
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}


function createMenu(menuData) {
    createMenuHTML(menuData, $('#system-menu'), "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        const listItem = $('<li class="menu-item"></li>').text(menuItem.systemTitle);
        const subMenu = $('<ul class="system-submenu"></ul>');

        const currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        // systemNo을 data attribute로 추가
        listItem.data("systemNo", menuItem.systemNo);

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
            $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
            $('.mymenu').slideUp();  // 메뉴 숨기기
            getProgressSummary(menuItem.systemNo);
        });

        parentElement.append(listItem);
    });
}

function getFeatureClassCommonCode(){
    $.ajax({
        url: '/getCommonCodeList?commonCodeNo=PMS010',
        type: 'GET',
        success: function (response){
            console.log("기능 종류 공통 코드 = " + response);
            response.forEach(function(option){
                console.log("각 옵션 객체 = ", option)
                const $option = $('<option>', {
                    value: option.codeDetailNo,
                    text: option.codeDetailName.trim()
                });
                $('#featClassOption').append($option);
            })
        }
    })
}


$('#featClassOption').change(function() {
    const selectedValue = $(this).val();
    const selectedText = $(this).find("option:selected").text();
    console.log("선택된 기능코드값:", selectedValue);
    console.log("선택된 기능분류명:", selectedText);

    const selectedSystemNo = $("#systemNo").val();
    console.log("선택된 systemNo:", selectedSystemNo);

    if (!selectedSystemNo) {
        return;
    }

    getProgressSummary(selectedSystemNo, selectedValue);
});




function animateProgressBar(progressBar, targetValue) {
    var value = 0;
    var max = 100;

    function animateProgress() {
        if (value < targetValue) {
            value++;
            progressBar.value = value;
            progressBar.nextElementSibling.textContent = value + '%';
            setTimeout(animateProgress, 15);
        }
    }

    animateProgress();
}