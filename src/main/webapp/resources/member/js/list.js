var teamMemberGrid;
var editMode = false;
var projectNo = 1;
$(document).ready(function() {
    loadTeamData(projectNo);  // 처음 로드 시 team 데이터를 불러오는 함수 호출

    $("#btnEdit").click(function () {
        toggleEditMode();  // 편집 모드 토글 함수
    });

    teamMemberGrid = new ax5.ui.grid();
    teamMemberGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="teamMemberGrid"]'),
        columns: [
            {key: "memberName", label: "성명", align: "center", formatter: function() {
                    return '<a href="#" class="clickable-name member-link" data-id="' + this.item.id + '">' + this.value + '</a>';
            }},
            {key: "auth", label: "프로젝트 권환", align: "center" },
            {key: "groupName", width: 110, label: "소속", align: "center"},
            {key: "position", width: 80, label: "직위",align: "center"},
            {key: "preStartDate", width: 120, label: "예정시작일",align: "center"},
            {key: "preEndDate", width:120, label: "예정종료일", align: "center"},
            {key: "startDate", width: 120, label: "참여시작일", align: "center" },
            {key: "endDate", width: 120, label: "참여종료일", align: "center"},
            {key: "tech", width: 80, label: "기술등급",align: "center"}
        ],
        page: {
            display: false
        }
    });


});

function openGroupPopup() {
    window.open(
        "/projects/addMember",
        "그룹등록",
        "width=1000, height=800, resizable=yes"
    );
}

// 팀 데이터를 불러오는 함수
function loadTeamData(projectNo) {
    $.ajax({
        url: 'http://localhost:8085/teams',
        method: 'GET',
        data: { projectNo: projectNo },
        success: function (response) {
            var treeData = response;
            renderTeamTree(treeData);  // FancyTree 초기화 함수 호출
        },
        error: function (error) {
            console.error("데이터를 가져오는 중 오류 발생:", error);
        }
    });
}

// 검색 기능 설정
function setupSearch() {
    var tree = $("#tree-table").fancytree("getTree");

    // 검색, 필터 로직
    $("input[name=search]").on("keyup", function(e) {
        var match = $(this).val();

        if(e && e.which === $.ui.keyCode.ESCAPE || $.trim(match) === ""){
            $("button#btnResetSearch").trigger("click");
            return;
        }

        var n = tree.filterNodes(match, {
            autoExpand: true,
            highlight: true,
            mode: "dimm"
        });

        tree.visit(function(node) {
            if (node.match || node.subMatch) {
                node.setExpanded(true);
            }
        });

        $("button#btnResetSearch").attr("disabled", false);
        $("span#matches").text("(" + n + "개 찾음)");
    });

    // 검색, 필터 리셋 버튼
    $("button#btnResetSearch").click(function(e) {
        $("input[name=search]").val("");
        $("span#matches").text("");
        tree.clearFilter();
        tree.visit(function(node) {
            node.setExpanded(false);  // 모든 노드를 접음
        });
    }).attr("disabled", true);
}

// FancyTree 초기화 함수
function renderTeamTree(treeData) {
    $("#tree-table").fancytree({
        extensions: ["table", "dnd5", "filter"],
        checkbox: false,
        selectMode: 1,
        quicksearch: true,
        source: treeData,
        icon: false,
        filter: {
            autoApply: true,
            autoExpand: true,
            counter: true,
            fuzzy: false,
            hideExpandedCounter: true,
            hideExpanders: false,
            highlight: true,
            leavesOnly: false,
            nodata: true,
            mode: "dimm"
        },
        table: {
            indentation: 20,
            nodeColumnIdx: 0,
            checkboxColumnIdx: 0
        },
        renderColumns: function (event, data) {
            var node = data.node,
                $tdList = $(node.tr).find(">td");

            $tdList.eq(0).text(node.data.title);
            $tdList.eq(1).text(node.data.systemName || "-");
            $tdList.eq(2).text(node.data.totalCount || "-");
        },
        dnd5: {
            autoExpandMS: 400,
            preventRecursion: false,
            dragStart: function (node, data) {
                return false;
            },
            dragEnter: function (node, data) {
                return false;
            },
            dragDrop: function (node, data) {
                data.otherNode.moveTo(node, data.hitMode);
            }
        },
        activate: function(event, data) {
            var node = data.node;
            var teamKey = node.key;
            var teamName = node.title;

            updateTeamInfo(node.data, teamName);
            loadTeamMembers(teamKey);
        }
    });

    setupSearch();
}

// 편집 모드 토글 함수
function toggleEditMode() {
    editMode = !editMode;
    if (editMode) {
        $("#btnEdit").text("저장");
        $(".fancytree-container").fancytree("option", "dnd5", {
            autoExpandMS: 400,
            preventRecursion: true,
            dragStart: function (node, data) {
                return true;
            },
            dragEnter: function (node, data) {
                return true;
            },
            dragDrop: function (node, data) {
                data.otherNode.moveTo(node, data.hitMode);
            }
        });
    } else {
        $("#btnEdit").text("순서 편집");
        $(".fancytree-container").fancytree("option", "dnd5", null);
        alert("순서가 저장되었습니다");
    }
}


// 선택된 팀의 정보를 표시하는 함수
function updateTeamInfo(teamData, teamName) {
    console.log(teamData);
    $("#team-name").text(teamName || "-");
    $("#parent-team-name").text(teamData.parentTeamName || "-");
    $("#system-name").text(teamData.systemName || "-");
    $("#team-description").text(teamData.teamDescription || "-");

    $(".header1").html('<span class="member-title">인력</span> ' + (teamData.totalCount || 0));
}


// 팀원 목록 불러오기
function loadTeamMembers(teamKey) {
    console.log("선택한 팀의 key: " + teamKey);

    $.ajax({
        url: 'http://localhost:8085/members',
        method: 'GET',
        data: {teamNo: teamKey},
        dataType: 'json',
        success: function(response) {
            console.log("팀원 목록 데이터:", response);
            teamMemberGrid.setData(response);
        },
        error: function(error) {
            console.error("팀원 목록 불러오기 실패:", error);
        }
    });
}


$(document).on("click", ".member-link", function(e) {
    e.preventDefault();
    var memberId = $(this).data("id");

    var memberData = teamMemberGrid.list.find(item => item.id === memberId);

    if (memberData) {
        updateMemberDetail(memberData);
    }
});

function updateMemberDetail(memberData) {
    // 성명, 프로젝트 권한, 직위, 기술등급, 이메일, 전화번호 정보 업데이트
    $("#member-name").text(memberData.memberName || '-');
    $("#project-auth").text(memberData.auth || '-');
    $("#tech-grade").text(memberData.tech || '-');
    $("#position").text(memberData.position || '-');
    $("#pre-start-date").text(memberData.preStartDate || '-');
    $("#pre-end-date").text(memberData.preEndDate || '-');
    $("#start-date").text(memberData.startDate || '-');
    $("#end-date").text(memberData.endDate || '-');
    $("#email").text(memberData.email || '-');
    $("#phone-no").text(memberData.phoneNo || '-');


    const teamTable = $(".team-table");
    teamTable.empty();

    memberData.connectTeams.forEach(team => {
        const row = `<tr>
                        <td>팀명</td>
                        <td>
                            <select>
                                <option>${team.teamName}</option>
                            </select>
                        </td>
                    </tr>`;
        teamTable.append(row);
    });

    $(".member-detail").show();
}


