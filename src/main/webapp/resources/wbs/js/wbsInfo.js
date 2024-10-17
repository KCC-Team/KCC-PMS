var queryString = window.location.search;
var queryParams = new URLSearchParams(queryString);
var type = queryParams.get('type');
var id = queryParams.get('id');
var parentId = queryParams.get('parentId');

$(document).ready(function() {

    // 처음 작업 생성
    if (type == 'new' && id == null) {
        $('#order_no').val(1);
        $('#ante_task_no').prop("disabled", true);
    }

    // 하위 작업 생성
    if (type == 'child' && id != null) {
        var child_no = parseInt(id) + 0.1;
        $('#order_no').val(child_no);
        if (parentId != null) {
            $('#par_task_no').val(parentId);
        }
    }

    // 인원 검색
    $('.btn-select-user').click(function () {
        window.open(
            "/projects/addMember?type=wbs",
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
        teamNo += member.teamNo + ", ";
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
