$(document).ready(function() {
    // 인원 검색
    $('.btn-select-user').click(function () {
        window.open(
            "/projects/addMember?type=wbs",
            "project",
            "width=1000, height=750, resizable=yes"
        );
    });
});

// 팝업 데이터 연결
window.addEventListener('message', function (event) {
    if (event.origin !== "http://localhost:8085") {
        return;
    }
    let addedMembers = event.data;

    console.log(addedMembers);

    // // 종료일 설정
    // if (addedMembers[0].end_dt != '') {
    //     document.getElementById('pm_end_dt').value = addedMembers[0].end_dt;
    // }
});
