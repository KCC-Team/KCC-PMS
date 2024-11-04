var firstGrid;

$(document.body).ready(function () {

    initFirstGrid().then(() => fetchGridData(1));

    fetchOptions();

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");
});

function initFirstGrid(){
    return new Promise((resolve) => {
        firstGrid = new ax5.ui.grid();

        firstGrid.setConfig({
            target: $('[data-ax5grid="first-grid"]'),
            columns: [
                {key: "riskTitle", label: "위험명", align: "center", width: 200, formatter: function() {
                        var title = this.value;
                        return '<a href="/projects/dangerInfo?no=' + encodeURIComponent(this.item.riskNo) + '" class="danger-title" style="color: #0044cc; font-size: 13px; font-weight: bold; text-decoration: none;">' + title + '</a>';
                    }},
                {key: "system", label: "시스템/업무명", align: "center", width: 230, formatter: function() {
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "className", label: "위험구분", width: 190, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + this.value + '</span>';
                    }},
                {key: "priority", label: "우선순위", width: 100, align: "center" , formatter: function (){
                        return '<span style="font-size: 13px;">' + this.value + '</span>';
                    }},
                {key: "status", label: "상태", width: 152, align: "center", formatter: function (){
                        var status = this.value.trim();
                        var statusClass = 'status-label ';

                        if (status === '진행중') {
                            statusClass += 'status-in-progress';
                        } else if (status === '발생전') {
                            statusClass += 'status-before';
                        } else if (status === '취소') {
                            statusClass += 'status-before';
                        }else if (status === '조치완료') {
                            statusClass += 'status-completed';
                        }

                        return '<span class="' + statusClass + '" style="font-size: 13px;">' + status + '</span>';
                    }},
                {key: "findMember", label: "발견자", width: 155, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "dueDateStr", label: "조치희망일", width: 150, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }},
                {key: "completeDateStr", label: "조치완료일", width: 150, align: "center", formatter: function (){
                        return '<span style="font-size: 13px;">' + (this.value ? this.value : '-') + '</span>';
                    }}
            ],
            page: {
                navigationItemCount: 5,
                size: 15,
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

        resolve();
    });
}

function fetchGridData(page) {
    let pageSize = 15;
    let systemNo = $('#systemNo').val();
    let selectedStatusNo = $("#PMS004").val();
    let selectedClassNo = $('#PMS005').val();
    let selectedPriorNo = $('#PMS006').val();
    let keyword = $('#riskSearchName').val();


    console.log("systemNo = " + systemNo);
    console.log("selectedStatusNo = " + selectedStatusNo);
    console.log("selectedClassNo = " + selectedClassNo);
    console.log("selectedPriorNo = " + selectedPriorNo);
    console.log("keyword = " + keyword);

    $.ajax({
        url: '/projects/risks',
        type: 'GET',
        data: {
            pageNum: page,
            amount: pageSize,
            systemNo: systemNo,
            selectedStatusNo: selectedStatusNo,
            selectedClassNo: selectedClassNo,
            selectedPriorNo: selectedPriorNo,
            keyword: keyword
        },
        success: function (response){
            console.log(response);
            updatePagination(response.items, response.pageInfo);
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
        }
    })
}

function updatePagination(items, pageInfo) {
    console.log(pageInfo.cri.pageNum);
    console.log(pageInfo.total);
    console.log(Math.ceil(pageInfo.total / 15));
    firstGrid.setData({
        list: items,
        page: {
            currentPage: pageInfo.cri.pageNum - 1,
            totalElements: pageInfo.total,
            totalPages: Math.ceil(pageInfo.total / 15),
            pageSize: 15
        }
    })
}


$('#riskSearchBtn').click(function (e){
    e.preventDefault();
    fetchGridData(1);
})

$('#PMS004').change(function (){
    fetchGridData(1);
})

$('#PMS005').change(function (){
    fetchGridData(1);
})

$('#PMS006').change(function (){
    fetchGridData(1);
})



function fetchOptions() {
    $.ajax({
        url: '/api/risk/options',
        method: 'GET',
        success: function(data) {
            console.log(data)
            data.forEach(function(item) {
                console.log(item);
                const selectId = '#' + item.common_cd_no;
                const $selectElement = $(selectId);

                if ($selectElement.length) {
                    setOptions($selectElement, item.codes);
                }
            });
        },
        error: function(xhr, status, error) {
            console.error('옵션 데이터를 가져오는데 실패했습니다.', error);
        }
    });
}

function setOptions($selectElement, options) {
    options.forEach(function(option) {
        // 각 option 태그 생성
        const $option = $('<option>', {
            value: option.cd_dtl_no,
            text: option.cd_dtl_nm
        });

        $selectElement.append($option);
    });
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
    const parentElement = $('#system-menu');

    // "전체" 메뉴 항목 추가
    const allMenuItem = $('<li class="menu-item"></li>').text("전체");
    allMenuItem.click(function(event) {
        event.stopPropagation();
        let projectTitle = document.querySelector('.common-project-title').textContent.trim();
        $('#system-select span:first-child').text(projectTitle);
        $('#systemNo').val("");  // 전체 시스템을 의미하도록 systemNo 필드 비우기
        $('.mymenu').slideUp();  // 메뉴 숨기기
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
            fetchGridData(1);
        });

        parentElement.append(listItem);
    });
}

$('.danger-export-excel').click(function (e) {
    e.preventDefault();
    $.ajax({
        url: '/projects/risks/excel',
        type: 'GET',
        xhrFields: {
            responseType: 'blob' // 바이너리 데이터를 받을 수 있도록 설정
        },
        success: function (response) {
            const blob = new Blob([response], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = 'RiskManagement.xlsx'; // 다운로드될 파일명
            link.click();
            window.URL.revokeObjectURL(link.href);
        },
        error: function (xhr, status, error) {
            console.error('엑셀 파일 다운로드에 실패했습니다.', error);
        }
    });
});