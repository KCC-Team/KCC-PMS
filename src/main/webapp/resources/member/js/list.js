var teamMemberGrid;

$(document).ready(function() {
    teamMemberGrid = new ax5.ui.grid();
    teamMemberGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="teamMemberGrid"]'),
        columns: [
            {key: "name", label: "성명", align: "center"},
            {key: "auth", label: "프로젝트 권환", align: "center" },
            {key: "group", width: 110, label: "소속", align: "center"},
            {key: "position", width: 80, label: "직위",align: "center"},
            {key: "pre_st_dt", width: 120, label: "예정시작일",align: "center"},
            {key: "pre_end_dt", width:120, label: "예정종료일", align: "center"},
            {key: "st_dt", width: 120, label: "참여시작일", align: "center" },
            {key: "end_dt", width: 120, label: "참여종료일", align: "center"},
            {key: "techGrade", width: 80, label: "기술등급",align: "center"}
        ],
        page: {
            display: false
        }
    });

    teamMemberGrid.setData([
        {id: 101, name: "김연호", auth: "PM", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", techGrade: "고급"},
    ]);
});

function openGroupPopup() {
    window.open(
        "/projects/addMember",
        "그룹등록",
        "width=1000, height=800, resizable=yes"
    );
}