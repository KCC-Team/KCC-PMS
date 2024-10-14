var teamMemberGrid;
var projectMemberGrid;
var editMode = false;
let isEditing = false;
var projectNo = 1;
$(document).ready(function() {
    // 동일한 모달을 여는 '그룹등록' 버튼 제어
    var openModalBtns = document.querySelectorAll(".openModalBtn");
    var modal = document.getElementById("teamModal");
    var closeBtn = document.querySelector(".close");

    // 모달 열기 버튼 클릭 시 모달 열기
    openModalBtns.forEach((btn) => {
        btn.addEventListener("click", function () {
            console.log("그룹등록버튼클릭");
            modal.style.display = "block";
        });
    });

    // 모달 닫기 버튼 클릭 시 모달 닫기
    closeBtn.addEventListener("click", function () {
        modal.style.display = "none";
    });

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };

    $('#team_title').on('input', function () {
        let maxByteLength = 200;
        let byteLength = limitByteLength($(this), maxByteLength);
        let targetId = $(this).attr('id');
    });


    $('#team_cont').on('input', function () {
        let maxByteLength = 1000;
        let byteLength = limitByteLength($(this), maxByteLength);
        $(".char-count").text(byteLength);
        let targetId = $(this).attr('id');
    });

    // 폼 제출 시 이벤트 처리
    document.getElementById("teamRegisterForm").addEventListener("submit", function(event) {
        event.preventDefault();
        // 서버로 폼 데이터 전송하는 로직 추가
        alert("팀이 등록되었습니다!");
        modal.style.display = "none"; // 등록 후 모달 닫기
    });

    $("#btnEdit").click(function () {
        toggleEditMode();  // 편집 모드 토글 함수
    });

    // 편집 버튼
    $('.member-edit-button').on('click', function () {
        var currentText = $(this).text();

        if (currentText === '편집') {
            isEditing = true;
            $(this).text('저장'); // 텍스트를 '저장'으로 변경
        } else {
            isEditing = false;
            $(this).text('편집'); // 텍스트를 '편집'으로 변경
        }

        // 그리드를 다시 렌더링해서 editor 상태를 반영
        projectMemberGrid.repaint();
    });

    initGrid();  // 공통 코드 로드 및 그리드 초기화
    loadTeamData(projectNo);
    loadProjectMembers(projectNo);
    $(".team-overview, .team-members").hide();
    $("#project-member-grid-section").show();
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
                if (data.hitMode === "before" || data.hitMode === "after" || data.hitMode === "over") {
                    data.otherNode.moveTo(node, data.hitMode);
                }
            }
        },
        activate: function(event, data) {
            var node = data.node;
            var teamKey = node.key;
            var teamName = node.title;

            if(node.data.parentId === null){
                $(".team-overview, .team-members, .member-detail").hide();
                $("#project-member-grid-section").show();
                loadProjectMembers(projectNo);
            } else {
                $(".team-overview, .team-members").show();
                $("#project-member-grid-section").hide();
                $(".member-detail").hide();
                updateTeamInfo(node.data, teamName);
                loadTeamMembers(teamKey);
            }

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
                if ((!node.parent || node.isTopLevel())) {
                    console.log("최상위 노드 위에 드롭 불가");
                    return false;
                }

                if (data.hitMode === "before" || data.hitMode === "after" || data.hitMode === "over") {
                    data.otherNode.moveTo(node, data.hitMode);
                }
                updateNodeOrder(data.otherNode, data.node, data.hitMode);
            }
        });
    } else {
        $("#btnEdit").text("순서 편집");
        $(".fancytree-container").fancytree("option", "dnd5", null);
        alert("순서가 저장되었습니다");
    }
}

//팀 순서 업데이트
function updateNodeOrder(movedNode, targetNode, hitMode) {
    const movedNodeId = movedNode.key;
    let newParentId;
    const newPosition = movedNode.getIndex();

    if (hitMode === 'over') {
        newParentId = targetNode.key;
    } else {
        newParentId = targetNode.parent ? targetNode.parent.key : null;
    }

    $.ajax({
        url: '/teams/updateOrder',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            teamNo: movedNodeId,
            newParentNo: newParentId,
            newPosition: newPosition
        }),
        success: function(response) {
            console.log('노드 순서가 성공적으로 반영되었습니다.');
        },
        error: function(xhr, status, error) {
            console.error('노드 순서 변경에 실패했습니다: ', error);
        }
    });
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
        url: 'http://localhost:8085/projects/members/team',
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
    } else {
        loadMemberDetails(memberId);
    }

    document.querySelector(".member-detail").scrollIntoView({ behavior: 'smooth' });
});

function loadMemberDetails(memberNo) {
    $.ajax({
        url: '/projects/members/detail',
        method: 'GET',
        data: { memberNo: memberNo },
        dataType: 'json',
        success: function(response) {
            updateMemberDetail(response);
        },
        error: function(error) {
            console.error("인력 상세 정보 불러오기 실패:", error);
        }
    });
}

function updateMemberDetail(memberData) {
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


// 프로젝트 팀원 목록을 불러오는 함수
function loadProjectMembers(projectNo) {
    $.ajax({
        url: 'http://localhost:8085/projects/projectmembers',
        method: 'GET',
        data: { projectNo: projectNo },
        dataType: 'json',
        success: function (response) {
            console.log("프로젝트 팀원 목록 데이터:", response);
            projectMemberGrid.setData(response);

        },
        error: function (error) {
            console.error("프로젝트 팀원 목록 불러오기 실패:", error);
        }
    });
}
//프로젝트 권환 공통 코드 가져오기
function loadAuthCommonCode() {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: '/getCommonCodeList',
            type: 'GET',
            data: {
                commonCodeNo: 'PMS002'
            },
            success: function(response) {
                var options = response.map(function(item) {
                    return {
                        CD: item.codeDetailNo,
                        NM: item.codeDetailName
                    };
                });
                resolve(options);
            },
            error: function(xhr, status, error) {
                console.error("공통 코드 로드 오류: ", error);
                reject(error);
            }
        });
    });
}

function initGrid() {
    // 공통 코드 가져오기
    loadAuthCommonCode().then(function(commonCodeOptions) {
        // teamMemberGrid 설정
        teamMemberGrid = new ax5.ui.grid();
        teamMemberGrid.setConfig({
            showRowSelector: true,
            target: $('[data-ax5grid="teamMemberGrid"]'),
            columns: [
                {key: "memberName", label: "성명", align: "center", formatter: function() {
                        return '<a href="#" class="clickable-name member-link" data-id="' + this.item.id + '">' + this.value + '</a>';
                    }},
                {
                    key: "auth",
                    label: "프로젝트 권환",
                    align: "center",
                    editor: {
                        type: "select",
                        config: {
                            columnKeys: {
                                optionValue: "CD",
                                optionText: "NM"
                            },
                            options: commonCodeOptions
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    },
                    formatter: function() {
                        var selectedOption = commonCodeOptions.find(function(option) {
                            return option.CD === this.value;
                        }.bind(this));
                        return selectedOption ? selectedOption.NM : this.value;
                    }
                },
                {key: "groupName", width: 110, label: "소속", align: "center"},
                {key: "position", width: 80, label: "직위", align: "center"},
                {key: "preStartDate", width: 120, label: "예정시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "preEndDate", width: 120, label: "예정종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "startDate", width: 120, label: "참여시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "endDate", width: 120, label: "참여종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "tech", width: 80, label: "기술등급", align: "center"}
            ],
            page: {
                display: false
            }
        });

        // projectMemberGrid 설정
        console.log(commonCodeOptions);
        projectMemberGrid = new ax5.ui.grid();
        projectMemberGrid.setConfig({
            showRowSelector: true,
            target: $('[data-ax5grid="projectMemberGrid"]'),
            columns: [
                {key: "memberName", label: "성명", align: "center", formatter: function() {
                        return '<a href="#" class="clickable-name member-link" data-id="' + this.item.id + '">' + this.value + '</a>';}},
                {
                    key: "auth",
                    label: "프로젝트권한",
                    align: "center",
                    editor: {
                        type: "select",
                        config: {
                            columnKeys: {
                                optionValue: "CD",
                                optionText: "NM"
                            },
                            options: commonCodeOptions
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    },
                    formatter: function() {
                        var selectedOption = commonCodeOptions.find(function(option) {
                            return option.CD === this.value;
                        }.bind(this));
                        return selectedOption ? selectedOption.NM : this.value;
                    }
                },
                {key: "groupName", width: 90, label: "소속", align: "center"},
                {key: "position", width: 80, label: "직위", align: "center"},
                {key: "tech", width: 80, label: "기술등급", align: "center"},
                {key: "teamName", width: 110, label: "소속팀", align: "center"},
                {key: "preStartDate", width: 100, label: "예정시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "preEndDate", width: 100, label: "예정종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "startDate", width: 100, label: "참여시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}},
                {key: "endDate", width: 100, label: "참여종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !isEditing;
                        }
                    }, formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}}
            ],
            page: {
                display: false
            }
        });

    }).catch(function(error) {
        console.error("그리드 초기화 오류: ", error);
    });
}

// 바이트 수 제한하는 함수
function limitByteLength(input, maxByteLength) {
    var text = input.val();
    var byteLength = 0;
    var newText = '';

    for (var i = 0; i < text.length; i++) {
        var char = text.charAt(i);
        // 한글 또는 특수문자는 3바이트
        if (escape(char).length > 4) {
            byteLength += 3;
        } else {
            // 영어, 숫자, 기호는 1바이트
            byteLength += 1;
        }

        if (byteLength > maxByteLength) {
            break; // 최대 바이트를 초과하면 반복 중단
        }
        newText += char; // 허용되는 범위 내의 문자만 추가
    }

    // 입력 값을 허용된 범위로 잘라내기
    input.val(newText);

    return byteLength;
}