var firstGrid;
var memberGrid;
let memberFullData = [];
let featureGrid; //멤버 기능 목록
let cachedMemberNo = null;
let cachedMemberName = null;
let chartInstances = []; // 차트 인스턴스를 저장할 배열
var delayGrid;
function openFeaturePopup(featureNo) {
    let url;
    if(featureNo != null){
        url = '/projects/features/register?featureNo=' + encodeURIComponent(featureNo);
    } else {
        url = '/projects/features/register'
    }

    let popupOptions = 'width=810,height=620,resizable=yes';
    window.open(url, '기능등록', popupOptions);
}

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('toggle-btn').click();

    setTimeout(function() {
        // 그리드 초기화 또는 데이터 로드 함수 호출
        initGrid().then(() => {
            getProjectFeatureProgressSummary();
        });

        initMemberGrid().then(() => {
            getMemberProgress();
        });

        initDelayGrid().then(() => {
            getDelayList();
        });


        getParentSystems(1, 3);
    }, 300);
});



$(document).ready(function (){
    window.addEventListener('message', function(event) {
        if (event.data.status === 'register') {
            console.log('Received:', event.data.message);
            console.log(event.data.featClassCd);
            console.log(event.data.systemNo);
            $('#featClassOption').val(event.data.featClassCd);
            $('#systemNo').val(event.data.systemNo);
            getProgressSummary(event.data.systemNo);
            setSystemPath(event.data.systemNo);
            fetchGridData(1);
            getParentSystems(1,3);
            getMemberProgress();
            getDelayList();
        } else if (event.data.status === 'update'){
            console.log('Received:', event.data.message);
            console.log(event.data.featClassCd);
            console.log(event.data.systemNo);
            console.log(event.data.featClassCd);
            $('#featClassOption').val(event.data.featClassCd);
            $('#systemNo').val(event.data.systemNo);
            getProgressSummary(event.data.systemNo, event.data.featClassCd);
            setSystemPath(event.data.systemNo);
            fetchGridData(1);
            getParentSystems(1,3);
            getMemberProgress();
            loadMemberFeatures(cachedMemberNo, cachedMemberName);
            getDelayList();
        }
    }, false);

    $(document).on('click', '.feat-info-row', function() {
        $(this).siblings().removeClass("on");
        $(this).addClass("on");
    });

    getFeatureClassCommonCode('PMS010');
    getFeatureClassCommonCode('PMS009');

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");




    setPageInfo(4);
    var projectTitle = $('.common-project-title').text().trim();
    $('.project-title').text(projectTitle);
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
    console.log("ajax 요청할 systemNo = " + systemNo);
    console.log("ajax 요청할 featClassCd = " + featClassCd);

    // 파라미터 설정 객체 생성
    let listParams = {};
    if (systemNo) listParams.systemNo = systemNo;
    if (featClassCd) listParams.featClassCd = featClassCd;

    $.ajax({
        url: '/projects/features/progress',
        type: 'GET',
        data: listParams,
        success: function (response) {
            console.log(response);
            updateMidPanel(response, $('#system-select span:first-child').text());
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
        }
    })
}

// 중앙 패널 업데이트 함수
function updateMidPanel(response, systemTitle) {
    $("#midSystemFeatureTitle").text(
        systemTitle + ($('#featClassOption').val() ? " > " + $('#featClassOption option:selected').text() : "")
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
}

function initGrid(){
    return new Promise((resolve) => {
        firstGrid = new ax5.ui.grid();

        firstGrid.setConfig({
            target: $('[data-ax5grid="first-grid"]'),
            columns: [
                {key: "featureTitle", label: "기능명", width: 100, align: "center", formatter: function (){
                        var featureNo = this.item.featureNo; // featureNo을 이용
                        var title = this.value;
                        console.log("기능NO: " + featureNo);
                        return '<a href="#" onclick="openFeaturePopup(' + featureNo + ')" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                    }},
                {key: "status", label: "상태", width: 103, align: "center", formatter: function (){
                        var status = this.value.trim();
                        var statusClass = 'status-label ';

                        if (status === '신규') {
                            statusClass += 'status-new';
                        } else if (status === '개발중') {
                            statusClass += 'status-in-progress';
                        } else if (status === '고객확인') {
                            statusClass += 'status-client-check';
                        } else if (status === '개발완료'){
                            statusClass += 'status-complete';
                        } else if (status === '단위테스트완료'){
                            statusClass += 'status-unit-test-complete';
                        } else if (status === 'PL확인') {
                            statusClass += 'status-pl-check';
                        }

                        return '<span class="' + statusClass + '" style="font-size: 13px;">' + status + '</span>';
                    }},
                {key: "memberName", label: "작업자", width: 70, align: "center" , formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "system", label: "시스템/업무", width: 150, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "progress", label: "진척도", width: 50, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + this.value + "%" + '</span>';
                    }},
                {key: "remainingDays", label: "남은일수", width: 60, align: "center", formatter: function (){
                        const value = this.value;
                        const color = value.startsWith('+') ? 'black' : 'red'; // '+'로 시작하지 않으면 빨간색, 그 외 검정색
                        return `<span style="font-size: 13px; color: ${color};">${value}</span>`;
                    }}
            ],
            page: {
                navigationItemCount: 5,
                size: 10,
                display: true,
                firstIcon: '<i class="fa fa-step-backward" aria-hidden="true"></i>',
                prevIcon: '<i class="fa fa-caret-left" aria-hidden="true"></i>',
                nextIcon: '<i class="fa fa-caret-right" aria-hidden="true"></i>',
                lastIcon: '<i class="fa fa-step-forward" aria-hidden="true"></i>',
                onChange: function () {
                    // 페이지가 바뀔 때 데이터 로드
                    var selectedPage = this.page.selectPage + 1;
                    fetchGridData(selectedPage);
                }
            }
        });

        resolve(); // 초기화 완료 후 resolve 호출
    })
}

function fetchGridData(page) {
    let pageSize = 10;
    let systemNo = $('#systemNo').val();
    let featClassCd = $('#featClassOption').val();
    let type = $('#featStatusOption').val();
    let keyword = $('#midSearchBar').val();

    let listParams = {
        systemNo: systemNo,
        featClassCd: featClassCd,
        page: page,
        pageSize: pageSize,
        type: type,
        keyword: keyword
    };

    $.ajax({
        url: '/projects/features/list',
        type: 'GET',
        data: listParams,
        success: function (response) {
            console.log("pagination!!!!!!", response);
            // 서버로부터 받은 데이터를 그리드와 페이지네이션에 반영
            // firstGrid.setData(response.items); // 그리드 데이터 설정
            updatePagination(response.items, response.pageInfo); // 페이지네이션 정보 업데이트
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
        }
    });
}

function updatePagination(items, pageInfo) {
    console.log(pageInfo.cri.pageNum);
    console.log(pageInfo.total);
    console.log(Math.ceil(pageInfo.total / 10));
    firstGrid.setData({
        list: items,
        page: {
            currentPage: pageInfo.cri.pageNum - 1,
            totalElements: pageInfo.total,
            totalPages: Math.ceil(pageInfo.total / 10),
            pageSize: 10
        }
    })
}



function initDelayGrid(){
    return new Promise((resolve) => {
        delayGrid = new ax5.ui.grid();

        delayGrid.setConfig({
            target: $('[data-ax5grid="delay-grid"]'),
            columns: [
                {key: "featureTitle", label: "기능명", width: 100, align: "center", formatter: function (){
                        var featureNo = this.item.featureNo; // featureNo을 이용
                        var title = this.value;
                        console.log("기능NO: " + featureNo);
                        return '<a href="#" onclick="openFeaturePopup(' + featureNo + ')" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                    }},
                {key: "status", label: "상태", width: 103, align: "center", formatter: function (){
                        var status = this.value.trim();
                        var statusClass = 'status-label ';

                        if (status === '신규') {
                            statusClass += 'status-new';
                        } else if (status === '개발중') {
                            statusClass += 'status-in-progress';
                        } else if (status === '고객확인') {
                            statusClass += 'status-client-check';
                        } else if (status === '개발완료'){
                            statusClass += 'status-complete';
                        } else if (status === '단위테스트완료'){
                            statusClass += 'status-unit-test-complete';
                        } else if (status === 'PL확인') {
                            statusClass += 'status-pl-check';
                        }

                        return '<span class="' + statusClass + '" style="font-size: 13px;">' + status + '</span>';
                    }},
                {key: "memberName", label: "작업자", width: 67, align: "center" , formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "system", label: "시스템/업무", width: 150, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "progress", label: "진척도", width: 50, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + this.value + "%" + '</span>';
                    }},
                {key: "remainingDays", label: "지연일수", width: 60, align: "center", formatter: function (){
                        return '<span style="font-size: 13px; color:red">' + this.value + '</span>';
                    }}
            ]
        });
        resolve();
    });
}

function getDelayList(){
    $.ajax({
        url: '/projects/features/list/delay',
        type: 'GET',
        success: function (response){
            console.log("delay list = ", response);
            delayGrid.setData(response);
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    })
}

function initMemberGrid(){
    return new Promise((resolve) => {
        memberGrid = new ax5.ui.grid();

        memberGrid.setConfig({
            target: $('[data-ax5grid="member-grid"]'),
            columns: [
                {
                    key: "memberName", label: "작업자", align: "center", width: 100, formatter: function () {
                        var title = this.value;
                        var memberNo = this.item.memberNo;
                        return '<a href="#" onclick="openMemberModal(' + memberNo + ', \'' + title + '\')" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                    }
                },
                {
                    key: "totalFeatureCount", label: "전체건", width: 60, align: "center", formatter: function () {
                        return '<span style="font-size: 13px;">' + this.value + '</span>';
                    }
                },
                {
                    key: "completedCount", label: "완료건", width: 60, align: "center", formatter: function () {
                        return '<span style="font-size: 13px;">' + this.value + '</span>';
                    }
                },
                {key: "inProgressCount", label: "진행건", width: 60, align: "center"},
                {
                    key: "delayedCount", label: "지연건", width: 60, align: "center", formatter: function () {
                        return '<span style="font-size: 13px; color: red;">' + this.value + '</span>';
                    }
                },
                {
                    key: "teamName", label: "소속팀", width: 120, align: "center", formatter: function () {
                        return '<span style="font-size: 13px;">' + this.value + '</span>';
                    }
                },
                {
                    key: "avgProgress", label: "진척도", width: 70, align: "center", formatter: function () {
                        return '<span style="font-size: 13px;">' + this.value + "%" +'</span>';
                    }
                }
            ]
        });
        resolve();
    });
}


function openMemberModal(memberNo, memberName) {
    cachedMemberNo = memberNo;
    cachedMemberName = memberName;

    $('#modalMemberName').text(memberName + ' 기능 목록');
    $('#memberFeatureModal').show();

    if (!featureGrid) {
        featureGrid = new ax5.ui.grid();
        featureGrid.setConfig({
            target: $('[data-ax5grid="feature-grid"]'),
            columns: [
                {
                    key: "featTitle",
                    label: "기능명",
                    width: 135,
                    align: "center",
                    formatter: function () {
                        var featureNo = this.item.featNo;
                        var title = this.value;
                        return '<a href="#" onclick="openFeaturePopup(' + featureNo + ')" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                    }
                },
                { key: "system", label: "시스템/업무", width: 160, align: "center" },
                {
                    key: "status", label: "상태", width: 120, align: "center",
                    formatter: function () {
                        var status = this.value.trim();
                        var statusClass = 'status-label ';

                        if (status === '신규') statusClass += 'status-new';
                        else if (status === '개발중') statusClass += 'status-in-progress';
                        else if (status === '고객확인') statusClass += 'status-client-check';
                        else if (status === '개발완료') statusClass += 'status-complete';
                        else if (status === '단위테스트완료') statusClass += 'status-unit-test-complete';
                        else if (status === 'PL확인') statusClass += 'status-pl-check';

                        return '<span class="' + statusClass + '" style="font-size: 13px;">' + status + '</span>';
                    }
                },
                { key: "preStartDate", label: "예정 시작일", width: 100, align: "center" },
                { key: "preEndDate", label: "예정 종료일", width: 100, align: "center" },
                { key: "startDate", label: "시작일", width: 100, align: "center" },
                { key: "endDate", label: "종료일", width: 100, align: "center" },
                {
                    key: "priority",
                    label: "우선순위",
                    width: 80,
                    align: "center",
                    formatter: function () {
                        var priority = this.value.trim();
                        var color = "";
                        switch (priority) {
                            case '즉시': color = '#ff0000'; break; // 빨강
                            case '긴급': color = '#ff4500'; break; // 주황
                            case '높음': color = '#ffa500'; break; // 노랑
                            case '보통': color = '#00bfff'; break; // 파랑
                            case '낮음': color = '#808080'; break; // 회색
                        }
                        return '<span style="color:' + color + '; font-size: 13px;">' + priority + '</span>';
                    }
                },
                {
                    key: "difficulty",
                    label: "난이도",
                    width: 80,
                    align: "center",
                    formatter: function () {
                        var difficulty = this.value.trim();
                        var color = "";
                        switch (difficulty) {
                            case '매우높음': color = '#8b0000'; break; // 진한 빨강
                            case '높음': color = '#ff4500'; break; // 주황
                            case '보통': color = '#ffa500'; break; // 노랑
                            case '낮음': color = '#00bfff'; break; // 파랑
                            case '매우낮음': color = '#808080'; break; // 회색
                        }
                        return '<span style="color:' + color + '; font-size: 13px;">' + difficulty + '</span>';
                    }
                },
                { key: "className", label: "기능 분류", width: 100, align: "center" },
                { key: "progress", label: "진척도", width: 80, align: "center", formatter: function() { return this.value + "%"; } },
            ]
        });
    }

    loadMemberFeatures(memberNo, memberName);
}


function loadMemberFeatures(memberNo, memberName) {
    $.ajax({
        url: '/projects/features/member/' + memberNo,
        type: 'GET',
        success: function(response) {
            console.log(response);
            const overallProgress = response.overallProgress || 0;
            $('#memberPrgVal').text(overallProgress + '%');
            $('#memberFeatBar').attr('value', overallProgress);

            // 기능 목록 데이터를 `features` 배열에서 가져옴
            const formattedData = response.features.map(item => ({
                ...item,
                preStartDate: item.preStartDate ? formatDate(item.preStartDate) : '-',
                preEndDate: item.preEndDate ? formatDate(item.preEndDate) : '-',
                startDate: item.startDate ? formatDate(item.startDate) : '-',
                endDate: item.endDate ? formatDate(item.endDate) : '-'
            }));

            featureGrid.setData(formattedData);
        },
        error: function(xhr, status, error) {
            console.error('작업자 기능 목록 로드 오류:', error);
        }
    });

    // 그래프 데이터 가져오기
    $.ajax({
        url: '/projects/features/member/' + memberNo + '/graph',
        type: 'GET',
        success: function(graphData) {
            console.log("그래프 데이터:", graphData);
            renderGraphs(graphData, memberName);  // 그래프 렌더링 함수 호출
        },
        error: function(xhr, status, error) {
            console.error('작업자 그래프 데이터 로드 오류:', error);
        }
    });
}

function renderGraphs(graphData, memberName) {
    // 기존 차트 인스턴스 제거
    chartInstances.forEach(chart => chart.destroy());
    chartInstances = []; // 배열 초기화

    graphData.forEach(data => {
        const chartId = data.category + 'Chart';
        const canvas = document.getElementById(chartId);

        // 기존 차트 제거 및 초기화
        if (Chart.getChart(chartId)) {
            Chart.getChart(chartId).destroy();
        }


        // 캔버스 크기 스타일 제거
        canvas.removeAttribute('style');

        const labels = data.graph.map(item => item.label.trim());
        const memberCounts = data.graph.map(item => item.memberCount);
        const avgCounts = data.graph.map(item => item.avgCount);

        // 각 차트에 맞는 제목 설정
        let chartTitle = '';
        switch (data.category) {
            case 'difficulty':
                chartTitle = '난이도별 기능 수';
                break;
            case 'status':
                chartTitle = '상태별 기능 수';
                break;
            case 'priority':
                chartTitle = '우선순위별 기능 수';
                break;
            case 'classification':
                chartTitle = '분류별 기능 수';
                break;
            default:
                chartTitle = '기능 데이터';
        }

        const chart = new Chart(canvas, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: memberName,
                        data: memberCounts,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                    },
                    {
                        label: '평균',
                        data: avgCounts,
                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                    }
                ]
            },
            options: {
                responsive: true, // 반응형으로 설정
                maintainAspectRatio: true, // 비율 유지
                aspectRatio: 5,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 6,
                        ticks: {
                            font: {
                                size: 12 // 고정된 글자 크기 설정
                            }
                        }
                    },
                    x: {
                        ticks: {
                            font: {
                                size: 12 // 고정된 글자 크기 설정
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        labels: {
                            font: {
                                size: 12 // 범례 텍스트 크기 고정
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: chartTitle, // 차트 제목 설정
                        font: {
                            size: 14
                        }
                    }
                }
            }
        });

        // 생성한 차트 인스턴스를 배열에 저장
        chartInstances.push(chart);
    });
}





function closeModal() {
    $('#memberFeatureModal').hide();

    // 저장된 모든 차트 인스턴스 제거
    chartInstances.forEach(chart => chart.destroy());
    chartInstances = []; // 배열 초기화

    // 캔버스와 스타일 초기화
    document.querySelectorAll('.chart-container canvas').forEach(canvas => {
        const ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        canvas.removeAttribute('style'); // 크기 스타일 초기화
    });

    // 모달의 다른 내용 초기화
    $('#memberPrgVal').text('0%');
    $('#memberFeatBar').attr('value', 0);
}


function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

function getMemberProgress(){
    $.ajax({
        url: '/projects/features/members',
        type: 'GET',
        success: function (response){
            console.log("memberProgress = ", response);
            memberFullData = response;
            memberGrid.setData(response);
        }
    })
}

function filterGridData() {
    var searchWord = $('#memberSearchBar').val().toLowerCase();
    var filteredData = memberFullData.filter(function (item) {
        return item.memberName.toLowerCase().includes(searchWord) || item.teamName.toLowerCase().includes(searchWord);
    });

    memberGrid.setData(filteredData);
}


$('#memberSearch').on('click', function (e) {
    e.preventDefault();
    filterGridData();
});



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
    const parentElement = $('#system-menu');

    // "전체" 메뉴 항목 추가
    const allMenuItem = $('<li class="menu-item"></li>').text("전체");
    allMenuItem.click(function(event) {
        event.stopPropagation();
        let projectTitle = document.querySelector('.common-project-title').textContent.trim();
        $('#system-select span:first-child').text(projectTitle);
        $('#systemNo').val("");  // 전체 시스템을 의미하도록 systemNo 필드 비우기
        $('.mymenu').slideUp();  // 메뉴 숨기기
        getProgressSummary();
        fetchGridData(1);
    });
    parentElement.append(allMenuItem);  // "전체" 메뉴 항목을 최상단에 추가

    // 기존 메뉴 생성
    createMenuHTML(menuData, parentElement, "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        var currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;
        var listItem = $('<li>', {
            'class': 'menu-item',
            'data-system-no': menuItem.systemNo,
            'data-parent-path': currentPath,
            'text': menuItem.systemTitle
        });

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            var subMenu = $('<ul>', {'class': 'system-submenu'});
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
            $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
            $('.mymenu').slideUp();  // 메뉴 숨기기
            getProgressSummary(menuItem.systemNo);
            fetchGridData(1)
        });

        parentElement.append(listItem);
    });
}

function getFeatureClassCommonCode(commonCodeNo){
    $.ajax({
        url: '/getCommonCodeList?commonCodeNo=' + commonCodeNo,
        type: 'GET',
        success: function (response){
            console.log("기능 종류 공통 코드 = " + response);
            response.forEach(function(option){
                console.log("각 옵션 객체 = ", option)
                const $option = $('<option>', {
                    value: option.codeDetailNo,
                    text: option.codeDetailName.trim()
                });
                if(commonCodeNo === 'PMS010'){
                    $('#featClassOption').append($option);
                } else {
                    $('#featStatusOption').append($option)
                }

            })
        }
    })
}


$('#featClassOption').change(function() {
    const selectedValue = $(this).val();
    const selectedText = $(this).find("option:selected").text();
    console.log("선택된 기능코드값:", selectedValue);
    console.log("선택된 기능분류명:", selectedText);

    const selectedSystemNo = $("#systemNo").val(); // `systemNo`가 비어 있으면 `null`로 설정
    console.log("선택된 systemNo:", selectedSystemNo);

    getProgressSummary(selectedSystemNo, selectedValue);
    fetchGridData(1);
});


$('#featStatusOption').change(function (){
    fetchGridData(1);
})

$('#featureSearch').click(function (e){
    e.preventDefault();
    fetchGridData(1);
})

function getParentSystems(pageNumber, pageSize) {
    const systemContainer = $("#system-container");
    systemContainer.empty(); // 새로운 페이지 로드 시 기존 데이터를 비워줌

    $.ajax({
        url: '/systems/parents?page=' + pageNumber + '&size=' + pageSize,
        type: 'GET',
        success: async function (response) {
            console.log("부모 시스템 page : " + pageNumber + " : ", response);

            const fetchPromises = response.map(system => {
                return fetchSystemProgress(system.systemNo, system.systemTitle);
            });

            const systemsProgressData = await Promise.all(fetchPromises);
            systemsProgressData.forEach(({ title, data }) => {
                updateSystemProgressUI(title, data);
            });
        },
        error: function (xhr, status, error) {
            console.error('Error fetching parent systems:', error);
        }
    });
}

function fetchSystemProgress(parentSystemNo, parentSystemTitle) {
    return new Promise((resolve, reject) => {
        $.ajax({
            url: '/projects/features/progress?systemNo=' + parentSystemNo + '&featClassCd=',
            type: 'GET',
            success: function (response) {
                console.log("부모시스템 조회", response);
                resolve({ title: parentSystemTitle, data: response });
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                reject(error);
            }
        });
    });
}

function updateSystemProgressUI(systemTitle, data) {
    const systemContainer = $("#system-container");
    const systemHTML = `
        <div class="feat-info-row">
            <div class="feat-title">${systemTitle}</div>
            <div class="prg-bar">
                <progress class="feat-bar" value="${data.progress || 0}" max="100"></progress>
                <span class="prg-val">${data.progress || 0}%</span>
            </div>
            <div class="feat-total">
                <span class="feat-total-cnt">${data.total || 0}</span><span class="total-name">건 - </span>
                <span class="total-name">(</span>
                <span class="feat-complete-cnt">${data.complete || 0}</span>
                <span class="total-name">건 완료, </span>
                <span class="feat-continue-cnt">${data.presentCount || 0}</span><span class="total-name">건 진행중, </span>
                <span class="feat-delay-cnt">${data.delay || 0}</span><span class="total-name">건 지연)</span>
            </div>
        </div>
    `;

    systemContainer.append(systemHTML);

    // 방금 추가한 요소에서 진척도 바를 선택하고 애니메이션 적용
    const progressBar = systemContainer.find(".feat-bar").last()[0];
    animateProgressBar(progressBar, data.progress || 0);
}

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

let currentPage = 1; // 현재 페이지
const pageSize = 3; // 한 페이지에 표시할 부모 시스템 개수
let totalPageCount = 0; // 총 페이지 수
const pageDisplayLimit = 3; // 화면에 표시할 페이지 번호 수

// 페이지 정보를 설정하는 함수
function setPageInfo(totalItems) {
    totalPageCount = Math.ceil(totalItems / pageSize); // 총 페이지 수 계산
    updatePaginationUI();
}

// 페이지 네비게이션 UI 업데이트
function updatePaginationUI() {
    const pageNumbersContainer = document.getElementById("page-numbers");
    pageNumbersContainer.innerHTML = ""; // 초기화

    // << 버튼
    const firstButton = document.createElement("button");
    firstButton.innerText = "<<";
    firstButton.onclick = () => changePage(1);
    firstButton.disabled = currentPage === 1;
    pageNumbersContainer.appendChild(firstButton);

    // < 버튼
    const prevButton = document.createElement("button");
    prevButton.innerText = "<";
    prevButton.onclick = () => changePage(currentPage - 1);
    prevButton.disabled = currentPage === 1;
    pageNumbersContainer.appendChild(prevButton);

    // 중간 페이지 번호 버튼들
    const startPage = Math.max(1, currentPage - Math.floor(pageDisplayLimit / 2));
    const endPage = Math.min(totalPageCount, startPage + pageDisplayLimit - 1);

    for (let i = startPage; i <= endPage; i++) {
        const pageButton = document.createElement("button");
        pageButton.innerText = i;
        pageButton.onclick = () => changePage(i);

        if (i === currentPage) {
            pageButton.classList.add("active"); // 현재 페이지에 강조 표시
        }

        pageNumbersContainer.appendChild(pageButton);
    }

    // > 버튼
    const nextButton = document.createElement("button");
    nextButton.innerText = ">";
    nextButton.onclick = () => changePage(currentPage + 1);
    nextButton.disabled = currentPage === totalPageCount;
    pageNumbersContainer.appendChild(nextButton);

    // >> 버튼
    const lastButton = document.createElement("button");
    lastButton.innerText = ">>";
    lastButton.onclick = () => changePage(totalPageCount);
    lastButton.disabled = currentPage === totalPageCount;
    pageNumbersContainer.appendChild(lastButton);
}

// 페이지 변경 시 호출되는 함수
function changePage(pageNumber) {
    if (pageNumber < 1 || pageNumber > totalPageCount) return; // 페이지 범위를 벗어나는 경우 무시
    currentPage = pageNumber;
    getParentSystems(currentPage, pageSize); // 새로운 페이지의 데이터 로드
    updatePaginationUI(); // 페이지 이동 후 UI 업데이트
}


function getProjectFeatureProgressSummary(){
    $.ajax({
        url: '/projects/features/totalProgress',
        type: 'GET',
        success: function (response){
            console.log("전체 진척도 및 기능 건수", response);

            // response에서 progress 값을 가져와서 사용
            var progressValue = response.progress / 100; // 100분율로 계산된 값을 1 기준으로 맞춤

            // circleProgress의 값을 업데이트
            $(".circle").circleProgress({
                value: progressValue,
                size: 260,
                fill: {
                    gradient: ["#3b82f6", "#f59e0b"]
                }
            }).on('circle-animation-progress', function (event, progress) {
                $(this).find('strong').html(parseInt(response.progress) + '<i>%</i>');
            });
            let projectTitle = document.querySelector('.common-project-title').textContent.trim();
            updateMidPanel(response, projectTitle);
            fetchGridData(1);
        },
        error: function (xhr, status, error){
            console.error('Error:', error);
        }
    })
}


function setSystemPath(systemNo) {
    var selectedItem = $('[data-system-no="' + systemNo + '"]');
    if (selectedItem.length) {
        var path = selectedItem.data('parent-path') || selectedItem.text(); // 'data-parent-path'를 사용하되, 없다면 text() 사용
        $('#system-select span:first-child').text(path);
    }
}