let currentPage = 1;
let testGrid;

$(function () {
    ax5.ui.grid.tmpl.page_status = function(){
        return '<span>{{{progress}}} {{fromRowIndex}} - {{toRowIndex}} of {{dataRowCount}} {{#dataRealRowCount}}  현재페이지 {{.}}{{/dataRealRowCount}} {{#totalElements}}  전체갯수 {{.}}{{/totalElements}}</span>';
    };

    testGrid = new ax5.ui.grid();
    testGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
        page: {
            navigationItemCount: 10,
            height: 30,
            display: true,
            firstIcon: '<i class="fa fa-step-backward" aria-hidden="true"></i>',
            prevIcon: '<i class="fa fa-caret-left" aria-hidden="true"></i>',
            nextIcon: '<i class="fa fa-caret-right" aria-hidden="true"></i>',
            lastIcon: '<i class="fa fa-step-forward" aria-hidden="true"></i>',
            onChange: function () {
                $('#systemNo').val() ? reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), this.page.selectPage+1) :
                    reloadDataTest(testGrid, 0, $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), this.page.selectPage+1);
            }
        },
        columns: [
            {key: "testItem", label: "테스트 ID", align: "center", width: 200, formatter: function() {
                    let item = this.value;
                    return '<a href="/projects/tests/' + encodeURIComponent(item.testNo) + '" class="defect-title" style="color: #2383f8; font-size: 13px; font-weight: bold; text-decoration: none;">' + item.testId + '</a>';
                }},
            {key: "testType", label: "구분", width: 90, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testTitle", label: "테스트 명", width: 463.3, align: "center" , formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testStatus", label: "상태", width: 100, align: "center", formatter: function (){
                    const status = this.value;
                    let statusClass = 'status-label ';

                    if (status === '진행전') {
                        statusClass += 'gray-status';
                    } else if (status === '진행중') {
                        statusClass += 'green-status';
                    } else if (status === '결함발생') {
                        statusClass += 'red-status';
                    } else if (status === '진행완료') {
                        statusClass += 'blue-status';
                    } else {
                        statusClass += 'red-status';
                    }

                    return '<span class="' + statusClass + '" style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "workTitle", label: "업무 구분", width: 117, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testStartDate", label: "시작일자", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "testEndDate", label: "종료일자", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "detailCount", label: "테스트 케이스", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
            {key: "defectCount", label: "결함", width: 90, align: "center", formatter: function (){
                    return '<span style="font-size: 13px;">' + this.value + '</span>';
                }},
        ],
    });

    reloadDataTest(testGrid, 0, "all", "all", "", 1);

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();
    });

    const urlParams = new URLSearchParams(window.location.search);
    const page = urlParams.get('page') || '1';

    $('.test-status').change(function() {
        reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), currentPage);
    });

    $('.test-opt').change(function() {
        reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), currentPage)
    });

    $('#searchTest').on('keypress', function(e) {
        if (e.key === 'Enter') {
            reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), currentPage);
        }
    });

    $('#test-search-btn').on('click', function(e) {
        console.log('test-search-btn');
        reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), currentPage);
    });

    fetchOptions();

    $('.add-test').on('click', function () {
        location.href = '/projects/tests/test';
    });
});

function reloadDataTest(testGrid, work, test, status, search, page) {
    const urlParams = new URLSearchParams(window.location.search);
    if (page !== currentPage) {
        currentPage = page;
    }
    $.ajax({
        method: "GET",
        url: "/projects/tests/api/list?work=" + work + "&testType=" + test + "&status=" + status + "&search=" + search + "&page=" + page,
        success: function (res) {
            console.log(res);
            testGrid.setData({
                list: res.testList,
                page: {
                    currentPage: currentPage-1,
                    pageSize: 15,
                    totalElements: res.totalElements,
                    totalPages: res.totalPage
                }
            });
        }, error: function (err) {
            console.error('그리드 데이터 가져오기 오류', err);
        }
    });
}

function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
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
        $('#systemNo').val("");
        $('.mymenu').slideUp();
        reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), selectPage);
    });
    parentElement.append(allMenuItem);

    createMenuHTML(menuData, parentElement, "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        let currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;
        let listItem = $('<li>', {
            'class': 'menu-item',
            'data-system-no': menuItem.systemNo,
            'data-parent-path': currentPath,
            'text': menuItem.systemTitle
        });

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            let subMenu = $('<ul>', {'class': 'system-submenu'});
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);
            $('#systemNo').val(menuItem.systemNo);
            $('.mymenu').slideUp();
            reloadDataTest(testGrid, $('#systemNo').val(), $('.test-opt').val(), $('.test-status').val(), $('#searchTest').val(), currentPage);
        });
        parentElement.append(listItem);
    });
}

function fetchOptions() {
    $.ajax({
        url: '/projects/tests/options',
        method: 'GET',
        success: function(data) {
            data.forEach(function(item) {
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