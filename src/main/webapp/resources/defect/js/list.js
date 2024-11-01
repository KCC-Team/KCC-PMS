let currentPage = 1;
let testGrid;

$(function () {
    let toast = new ax5.ui.toast({
        containerPosition: "top-right",
        onStateChanged: function(){
            console.log(this);
        }
    });

    window.toastDefect = toast;
    window.addEventListener('defectDeleted', function (e) {
        toast.push({
            theme: 'success',
            msg: "결함 내역 삭제가 완료되었습니다."
        }, function () {
            console.log(this);
        });
    });

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
            {key: "defectTitle", label: "결함명", width: 418, align: "left" , formatter: function (){
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
                if (this.value) {
                    return '<span style="font-size: 12px;">' + this.value + '</span>';
                } else {
                    return '-';
                }
            }},
            {key: "discoverDate", label: "발견일자", width: 130, align: "center", formatter: function (){
                    if (this.value) {
                        return '<span style="font-size: 12px;">' + this.value.substring(0, 10) + '</span>';
                    } else {
                        return '-';
                    }
            }},
            {key: "scheduleWorkDate", label: "조치예정일자", width: 130, align: "center", formatter: function (){
                    if (this.value) {
                        return '<span style="font-size: 12px;">' + this.value.substring(0, 10) + '</span>';
                    } else {
                        return '-';
                    }
            }},
            {key: "workDate", label: "조치일자", width: 130, align: "center", formatter: function (){
                    if (this.value) {
                        return '<span style="font-size: 12px;">' + this.value.substring(0, 10) + '</span>';
                    } else {
                        return '-';
                    }
            }}
        ],
    });

    reloadData(testGrid, 0, "all", "all", "", currentPage);

    $(document).on('click', '.defect-id', function(e) {
        e.preventDefault();
       let popup = window.open($(this).attr('href'), 'popup', 'width=1150, height=810');
    });

    $(document).on('click', '.add-defect', function(e) {
        e.preventDefault();
        let popup = window.open('/projects/defects/defect', 'popup', 'width=1150, height=810');
    });

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();
    });

    $('.defect-status').change(function() {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $(this).val(), "", currentPage) : reloadData(testGrid, 0, $('.defect-opt').val(), $(this).val(), $('#searchDefect').val(), currentPage);
    });

    $('#searchDefect').on('keypress', function(e) {
        if (e.key === 'Enter') {
            $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage) :
            reloadData(testGrid, 0, $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage);
        }
    });

    $('.defect-opt').change(function() {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $(this).val(), $('.defect-status').val(), "", currentPage) : reloadData(testGrid, 0, $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage);
    });

    $('#defect-search-btn').on('click', function(e) {
        $('#systemNo').val() ? reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage) :
        reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage);
    });

    fetchOptions();
});

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
        $('#systemNo').val("");  // 전체 시스템을 의미하도록 systemNo 필드 비우기
        $('.mymenu').slideUp();  // 메뉴 숨기기
        reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage);
    });
    parentElement.append(allMenuItem);  // "전체" 메뉴 항목을 최상단에 추가

    // 기존 메뉴 생성
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
            $('#system-select span:first-child').text(currentPath); // 선택된 경로 표시
            $('#systemNo').val(menuItem.systemNo); // 시스템 번호를 숨겨진 필드에 저장
            $('.mymenu').slideUp(); // 메뉴 숨기기
            reloadData(testGrid, $('#systemNo').val(), $('.defect-opt').val(), $('.defect-status').val(), $('#searchDefect').val(), currentPage);
        });
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
        url: "/projects/defects/api/list?workNo=" + work + "&type=" + type + "&status=" + status + "&search=" + search + "&page=" + page,
            success: function (res) {
                testGrid.setData({
                    list: res.defectList,
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

function fetchOptions() {
    $.ajax({
        url: '/projects/defects/options',
        method: 'GET',
        success: function(data) {
            console.log(data)
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
