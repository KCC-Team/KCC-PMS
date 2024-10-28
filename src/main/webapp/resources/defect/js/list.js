const API_SERVER = 'http://localhost:8085';
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
                $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), this.page.selectPage+1) :
                    reloadData(testGrid, 0, $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), this.page.selectPage+1);
            }
        },
        columns: [
            {key: "defectItem", label: "결함 ID", align: "center", width: 150, formatter: function() {
                    let item = this.value;
                    return '<input type=hidden name=defect_id value=${item.defectNumber} />' +
                        '<a href="/projects/defects/' + encodeURIComponent(item.defectNumber) + '" class="defect-id" style="color: #2383f8; font-size: 13px; font-weight: bold; text-decoration: none;">' + item.defectId + '</a>';
                }},
            {key: "defectTitle", label: "결함명", width: 400, align: "left" , formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "priority", label: "우선순위", width: 100, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "status", label: "상태", width: 101, align: "center", formatter: function (){
                    let status = this.value.trim();
                    let statusClass = 'status-label ';

                    if (status === '진행중') {
                        statusClass += 'green-status';
                    } else if (status === '해결') {
                        statusClass += 'blue-status';
                    } else if (status === '취소') {
                        statusClass += 'cancel-status';
                    } else if (status === '신규') {
                        statusClass += 'red-status';
                    }

                    return '<span class="' + statusClass + '" style="font-size: 12px;">' + this.value + '</span>';
                }
            },
            {key: "discoverName", label: "발견자", width: 101, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "workName", label: "조치자", width: 101, align: "center", formatter: function (){
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                }},
            {key: "discoverDate", label: "발견일자", width: 130, align: "center", formatter: function (){
                    if (this.value) {
                        return '<span style="font-size: 12px;">' + this.value.substring(0, 10) + '</span>';
                    } else {
                        return '';
                    }
                }},
            {key: "scheduleWorkDate", label: "조치예정일자", width: 130, align: "center", formatter: function (){
                    if (this.value) {
                        return '<span style="font-size: 12px;">' + this.value.substring(0, 10) + '</span>';
                    } else {
                        return '';
                    }
                }},
            {key: "workDate", label: "조치일자", width: 130, align: "center", formatter: function (){
                    if (this.value) {
                        return '<span style="font-size: 12px;">' + this.value.substring(0, 10) + '</span>';
                    } else {
                        return '';
                    }
                }}
        ],
    });

    reloadData(testGrid, 0, "all", "all", "", currentPage);

    $(document).on('click', '.defect-id', function(e) {
        e.preventDefault();
       let popup = window.open($(this).attr('href'), 'popup', 'width=1150, height=790');
    });

    $(document).on('click', '.add-defect', function(e) {
        e.preventDefault();
        let popup = window.open('/projects/defects/defect', 'popup', 'width=1150, height=790');
    });

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();
    });

    $('.defect-status').change(function() {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $(this).val(), "", currentPage) : reloadData(testGrid, 0, $('.defect-opt').val(), $(this).val(), "", currentPage);
    });

    $('.defect-opt').change(function() {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $(this).val(), $('.defect-status').val(), "", currentPage) : reloadData(testGrid, 0, $('.defect-opt').val(), $('.defect-status').val(), "", currentPage);
    });

    $('#defect-search-btn').on('click', function(e) {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage) :
        reloadData(testGrid, 0, $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage);
    });
});

function fetchMenuData() {
    return $.ajax({
        url: '/systems',
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
    createMenuHTML(menuData, $('#system-menu'), "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        const listItem = $('<li class="menu-item"></li>');
        const itemLabel = $('<span></span>').text(menuItem.systemTitle);
        listItem.append(itemLabel);

        const subMenu = $('<ul class="system-submenu"></ul>');
        const currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);

            // 하위 메뉴 토글 기능 추가
            itemLabel.click(function(event) {
                event.stopPropagation();
                subMenu.slideToggle();
            });
        } else {
            // 하위 메뉴가 없는 경우 클릭 시 시스템 선택
            itemLabel.click(function(event) {
                event.stopPropagation();
                $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
                $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
                $('#system-menu').slideUp();  // 메뉴 숨기기

                let select = $('.defect-status').val();
                reloadData(testGrid, menuItem.systemNo, $('.defect-opt').val(), select, "", currentPage);
            });
        }

        parentElement.append(listItem);
    });
}

function reloadData(testGrid, work, type, status, search, page) {
    const urlParams = new URLSearchParams(window.location.search);

    if (page !== currentPage) {
        currentPage = page;
    }

    $.ajax({
        method: "GET",
        url: API_SERVER + "/projects/defects/api/list?workNo=" + work + "&type=" + type + "&status=" + status + "&search=" + search + "&page=" + page,
            success: function (res) {
                console.log('그리드 데이터 가져오기 성공', res);
                testGrid.setData({
                    list: res.defectList,
                    page: {
                        currentPage: currentPage-1,
                        pageSize: 10,
                        totalElements: res.totalElements,
                        totalPages: res.totalPage
                    }
                });
        }, error: function (err) {
            console.error('그리드 데이터 가져오기 오류', err);
        }
    });
}