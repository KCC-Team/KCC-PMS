let queryString = window.location.search;
let queryParams = new URLSearchParams(queryString);
let type = queryParams.get('type');
let id = queryParams.get('id');
let max_order_id = queryParams.get('maxOrderId');

if (type == "view" && id != null) {
    getWbsInfo(id);
    $("#par_task_nm_row").show();
}

$(document).ready(function() {

    $("#pre_st_dt, #pre_end_dt, #st_dt, #end_dt").datepicker({
        dateFormat: "yy-mm-dd"
    });

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");

    // 인원 검색
    $('.btn-select-user').click(function () {
        window.open(
            "/projects/addMember?prjNo=" + prjNo +"&type=wbs",
            "project",
            "width=1000, height=750, resizable=yes"
        );
    });

    // form 전송
    $('#wbs_form').on('submit', function (event) {
        event.preventDefault();

        $('#max_order_id').val(max_order_id);

        // WBS 등록
        if (type == 'new' || type == 'child') {
            $.ajax({
                url: '/projects/api/wbs',
                type: 'POST',
                data: $(this).serialize(),
                success: function (response) {
                    alert('작업이 등록되었습니다.');
                    window.close();
                    //window.opener.location.reload();
                    window.opener.getProjectResult();
                },
                error: function (xhr, status, error) {
                    console.error('에러:', xhr.responseText);
                    alert('저장 중 에러가 발생했습니다. 다시 시도해 주세요.');
                    return false;
                }
            });
        }

        // WBS 수정
        if (type == 'view') {
            $("#tsk_no").val(id);

            $.ajax({
                url: '/projects/api/wbs',
                type: 'PUT',
                data: $(this).serialize(),
                success: function(response) {
                    alert('작업이 수정되었습니다.');
                    //window.opener.location.reload();
                    window.opener.getProjectResult();
                },
                error: function(xhr, status, error) {
                    console.error('에러:', xhr.responseText);
                    alert('수정 중 에러가 발생했습니다. 다시 시도해 주세요.');
                    return false;
                }
            });
        }
    });

});


// 인력등록 팝업 연결
window.addEventListener('message', function (event) {
    if (event.origin !== "http://localhost:8085") {
        return;
    }

    let addedMembers = event.data;
    let membersId = "";
    let teamNo = "";
    let membersName = "";

    console.log(addedMembers);

    addedMembers.forEach(function(member) {
        membersId += member.id + ", ";
        teamNo += member.connectTeams[0].teamNo + ", ";
        membersName += member.name + ", ";
    });

    if (membersId.includes(',')) {
        membersId = membersId.substring(0, membersId.length - 2);
    }
    if (teamNo.includes(',')) {
        teamNo = teamNo.substring(0, teamNo.length - 2);
    }
    if (membersName.includes(',')) {
        membersName = membersName.substring(0, membersName.length - 2);
    }

    $("#mem_no").val(membersId);
    $("#tm_no").val(teamNo);
    $("#mem_nm").val(membersName);
});

// 상세정보 조회
function getWbsInfo(id) {
    $.ajax({
        url: '/projects/api/wbs/info',
        type: 'GET',
        data: {
            tsk_no: id
        },
        success: function (res) {
            console.log(res[0]);

            $("#mem_no").val(res[0].mem_numbers);
            $("#tm_no").val(res[0].tm_numbers);
            $("#mem_nm").val(res[0].mem_nms);
            $("#tsk_ttl").val(res[0].tsk_ttl);
            $("#tsk_stat_cd").val(res[0].tsk_stat_cd);
            $("#pre_st_dt").val(res[0].pre_st_dt);
            $("#pre_end_dt").val(res[0].pre_end_dt);
            $("#st_dt").val(res[0].st_dt);
            $("#end_dt").val(res[0].end_dt);
            $("#prg").val(res[0].prg);
            $("#weight_val").val(res[0].weight_val);
            $("#rel_out_nm").val(res[0].rel_out_nm);
            $("#sys_no").val(res[0].sys_no);

        },
        error: function (xhr, status, error) {
            console.error('에러:', xhr.responseText);
            alert('조회 중 에러가 발생했습니다. 다시 시도해 주세요.');
            return false;
        }
    });
    getTopTaskList(id);
}

// 상위 작업 조회 후 노출
function getTopTaskList(id) {
    $.ajax({
        url: '/projects/api/wbs/topTask',
        type: 'GET',
        data: {
            tsk_no: id
        },
        success: function (res) {
            let task_ttl_name = "";
            res.forEach(function(item) {
                task_ttl_name += item.tsk_ttl + " > ";
            });
            task_ttl_name = task_ttl_name.slice(0, -2);
            $("#par_task_nm").val(task_ttl_name);
        },
        error: function (xhr, status, error) {
            console.error('에러:', xhr.responseText);
            alert('조회 중 에러가 발생했습니다. 다시 시도해 주세요.');
            return false;
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
    createMenuHTML(menuData, $('#system-menu'), "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        const listItem = $('<li class="menu-item"></li>').text(menuItem.systemTitle);
        const subMenu = $('<ul class="system-submenu"></ul>');
        const currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;

        if ($('#sys_no').val() == menuItem.systemNo)  {
            $('#system-select span:first-child').text(currentPath);
        }

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
            $('#sys_no').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
            $('.mymenu').slideUp();  // 메뉴 숨기기
        });

        parentElement.append(listItem);
    });
}