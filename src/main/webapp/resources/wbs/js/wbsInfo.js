var queryString = window.location.search;
var queryParams = new URLSearchParams(queryString);
var type = queryParams.get('type');
var id = queryParams.get('id');
var parentId = queryParams.get('parentId');
var depth = "";

$(document).ready(function() {

    $("#pre_st_dt, #pre_end_dt, #st_dt, #end_dt").datepicker({
        dateFormat: "yy-mm-dd"  // 원하는 형식으로 날짜 표시
    });

    // // 처음 작업 생성
    // if (type == 'new' && id == null) {
    //     $('#order_no').val(1);
    //     $('#ante_task_no').prop("disabled", true);
    // }
    //
    // // 아래에 작업 생성
    // if (type == 'new' && id != null) {
    //     $('#order_no').val(getNewOrderno(id));
    // }
    // // 아래에 작업 생성
    // if (type == 'new' && id != null && parentId != null) {
    //     $('#order_no').val(getNewOrderno(id));
    //     $('#par_task_no').val(parentId);
    // }
    //
    // // 하위 작업 생성(신규)
    // if (type == 'child' && id == 0) {
    //     var child_no = "";
    //     var checkDepth = parentId.length;
    //     if (checkDepth == 1) {
    //         child_no = (parseFloat(parentId) + 0.1).toFixed(1);
    //     } else if (checkDepth == 3) {
    //         child_no = (parseFloat(parentId) + 0.001).toFixed(3);
    //     }
    //     $('#order_no').val(child_no);
    //     $('#par_task_no').val(parentId);
    // }

    // // 하위 작업 생성(하위)
    // if (type == 'child' && id != 0) {
    //     var child_no = "";
    //     var checkDepth = id.length;
    //     if (checkDepth == 3) {
    //         child_no = (parseFloat(id) + 0.1).toFixed(1);
    //     } else if (checkDepth == 5) {
    //         child_no = (parseFloat(id) + 0.001).toFixed(3);
    //     }
    //     $('#order_no').val(child_no);
    //     $('#par_task_no').val(parentId);
    // }

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

        if ($('#ante_task_no').val().length > 0 && !/^\d+(\.\d+)*$/.test($('#ante_task_no').val())) {
            alert('올바른 선행작업 번호를 입력해주세요.');
            return false;
        }

        // 프로젝트 등록
        if (type == 'new' || type == 'child') {
            $.ajax({
                url: '/projects/api/wbs',
                type: 'POST',
                data: $(this).serialize(),
                success: function (response) {
                    alert('작업이 등록되었습니다.');
                    window.close();
                    window.opener.location.reload();
                },
                error: function (xhr, status, error) {
                    console.error('에러:', xhr.responseText);
                    alert('저장 중 에러가 발생했습니다. 다시 시도해 주세요.');
                    return false;
                }
            });
        }

        // // 프로젝트 수정
        // if (type == 'view') {
        //     $.ajax({
        //         url: '/projects/api/wbs',
        //         type: 'PUT',
        //         data: $(this).serialize(),
        //         success: function(response) {
        //             alert('작업이 수정되었습니다.');
        //         },
        //         error: function(xhr, status, error) {
        //             console.error('에러:', xhr.responseText);
        //             alert('수정 중 에러가 발생했습니다. 다시 시도해 주세요.');
        //             return false;
        //         }
        //     });
        // }
    });

    function checkDepth(id) {
        let parts = id.split('.').map(Number);
        if (parts.length === 1) {
            return "1";
        } else if (parts.length === 2) {
            return "2";
        } else if (parts.length === 3) {
            return "3";
        }
    }

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


function getNewOrderno(id) {
    // 점(.)을 기준으로 버전 문자열을 분리
    let parts = id.split('.').map(Number);

    if (parts.length === 1) {
        // 숫자가 하나인 경우에는 1을 더한다 (예: '1' -> '2')
        parts[0] += 1;
    } else if (parts.length === 2) {
        // 두 부분이면 두 번째 부분에 1을 더한다 (예: '1.1' -> '1.2')
        parts[1] += 1;
    } else if (parts.length === 3) {
        // 세 부분이면 세 번째 부분에 1을 더한다 (예: '1.1.1' -> '1.1.2')
        parts[2] += 1;
    }

    // 버전 번호를 다시 '.'으로 연결하여 반환
    return parts.join('.');
}
