const API_SERVER = 'http://localhost:8085';
let testGrid;
$(function () {
    testGrid = new ax5.ui.grid();

    testGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),
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

    reloadData(testGrid, 0, "all", "");

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
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $(this).val(), "") : reloadData(testGrid, 0, $(this).val(), "");
    });

    $('#defect-search-btn').on('click', function(e) {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-status').val(), $('#searchDefect').val()) :
        reloadData(testGrid, 0, $('.defect-status').val(), $('#searchDefect').val());
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
                reloadData(testGrid, menuItem.systemNo, select, "");
            });
        }

        parentElement.append(listItem);
    });
}

function reloadData(testGrid, work, status, search) {
    const urlParams = new URLSearchParams(window.location.search);
    const page = urlParams.get('page') || '1';

    $.ajax({
        method: "GET",
        url: API_SERVER + "/projects/defects/api/list?workNo=" + work + "&status=" + status + "&search=" + search + "&page=" + page,
            success: function (res) {
            testGrid.setData(res);
        }, error: function (err) {
            console.error('그리드 데이터 가져오기 오류', err);
        }
    });
}