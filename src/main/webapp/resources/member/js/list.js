var teamMemberGrid;
var projectMemberGrid;
var editMode = false;


$(document).ready(function() {

    window.addEventListener('message', function(event) {
        if (event.data && event.data.type === 'updateTree') {
            // FancyTree를 다시 로드
            loadProjectMembers(prjNo);
            loadTeamData(prjNo);
            loadTeamMembers(event.data.teamNo);

            console.log("팝업으로 받은 팀넘버 : " + event.data.teamNo);

        }
    });

    // 동일한 모달을 여는 '그룹등록' 버튼 제어
    var openModalBtns = $(".openModalBtn");
    var modal = $("#teamModal");

    // 모달 열기 버튼 클릭 시 모달 열기
    openModalBtns.each(function() {
        $(this).on("click", function () {

            $("#teamRegisterForm")[0].reset();

            $("#team_title").val("");
            $("#parent-team").prop('selectedIndex', 0);
            $("#system-select span:first").text("시스템 선택");
            $("#team_cont").val("");
            $(".char-count").text("0");

            modal.show();
        });
    });

    // 모달 닫기 버튼 클릭 시 모달 닫기
    $(".close").on("click", function () {
        modal.hide();
    });

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });


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

    $('#teamRegisterForm').on('submit', function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지
        const formData = getTeamFormData();
        submitTeamCreation(formData);
    });

    loadTeamOptions('#parent-team');


    $("#btnEdit").click(function () {
        toggleEditMode();
    });

    // 편집 버튼
    // $('.member-edit-button').on('click', function () {
    //     var currentText = $(this).text();
    //
    //     if (currentText === '편집') {
    //         isEditing = true;
    //         $(this).text('저장'); // 텍스트를 '저장'으로 변경
    //     } else {
    //         isEditing = false;
    //         $(this).text('편집'); // 텍스트를 '편집'으로 변경
    //
    //         // 변경된 행 출력
    //         console.log("변경된 행:", modifiedRows);
    //
    //         // 저장이 완료된 후 변경된 행 배열 초기화
    //         modifiedRows = [];
    //     }
    //
    //     // 그리드를 다시 렌더링해서 editor 상태를 반영
    //     projectMemberGrid.repaint();
    // });



    initGrid().then(function() {
        // 그리드가 초기화된 후 프로젝트 멤버 목록 로드
        loadProjectMembers(prjNo);
    });
    loadTeamData(prjNo);

    $(document).on('click', '.clickable-name', function() {
        console.log('클릭된 요소:', $(this));
    });
    $(document).on('mousedown', '.clickable-name', function(e) {
        const projectMemberSelectedMembers = projectMemberGrid.getList('selected');
        const teamMemberSelectedMembers = teamMemberGrid.getList('selected');
        console.log(projectMemberSelectedMembers);
        console.log(teamMemberSelectedMembers);


        let teamLoadStatus = '';
        let teamLoadNo;
        const selectedMembers = (teamMemberSelectedMembers && teamMemberSelectedMembers.length > 0)
            ? (teamLoadStatus = 'teamLoad',  teamLoadNo = teamMemberSelectedMembers[0].teamNo ,teamMemberSelectedMembers)  // teamLoad 설정
            : projectMemberSelectedMembers;


        console.log("teamLoadNo = " + teamLoadNo);
        console.log("selectedMembers");
        console.log(selectedMembers);

        if (selectedMembers.length === 0) {
            return; // 선택된 멤버가 없으면 종료
        }

        const clickedElement = $(this);
        console.log("mouseDOWN");
        console.log(clickedElement);

        const memberName = clickedElement.text();
        const memberId = clickedElement.data('id');
        const beforeTeamNo = clickedElement.data('teamno');

        console.log('mousedown클릭된 요소:', $(this));
        console.log("memberId = " + memberId);
        console.log("beforeTeamNo" + beforeTeamNo);

        // 새로운 드래그 가능한 div 생성
        const dragDiv = $('<div></div>')
            .text(memberName)
            .css({
                position: 'absolute',
                top: e.pageY + 'px',
                left: e.pageX + 'px',
                backgroundColor: '#f0f0f0',
                padding: '10px',
                border: '1px solid #ccc',
                borderRadius: '5px',
                zIndex: 1000,
                opacity: 0.8
            })
            .attr('id', 'dragging-div')
            .data('selected-members', selectedMembers)
            .appendTo('body');

        // 마우스 이동 이벤트로 dragDiv를 움직이게 함
        $(document).on('mousemove', function(e) {
            $('#dragging-div').css({
                top: e.pageY + 'px',
                left: e.pageX + 'px'
            });
        });

        // 드래그가 끝나면(div 제거 및 이벤트 해제)
        $(document).on('mouseup', function(event) {
            var $target = $(event.target);

            // FancyTree 노드 위에 드롭했는지 확인
            if ($target.closest('.fancytree-node').length > 0) {
                const teamNode = $.ui.fancytree.getNode($target);
                const teamId = teamNode.key;
                const selectedMembers = $('#dragging-div').data('selected-members');

                // selectedMembers.forEach(member => {
                //     const { memberId, beforeTeamNo } = member;
                //     console.log("이동하려는 팀 : " + teamId);
                //     console.log("이동하려는 멤버 : " + member.id);
                //     console.log("원래 소속 팀 : " + member.teamNo);
                //
                //     // 각 멤버에 대해 팀 변경 API 호출
                //     memberAssignTeam(teamId, member.id, member.teamNo);
                // });
                const members = selectedMembers.map(member => ({
                    memberId: member.id,
                    beforeTeamNo: member.teamNo
                }));

                console.log("이동하려는 팀 : " + teamId);
                console.log("이동하려는 멤버들 : ", members);

                memberAssignTeam(teamId, members, teamLoadStatus, teamLoadNo);
            }
            $('#dragging-div').remove();
            $(document).off('mousemove');
            $(document).off('mouseup');
        });

    });


    setTimeout(function (){
        $(".team-overview, .team-members").hide();
    }, 100);

    $("#project-member-grid-section").show();
});

function openGroupPopup() {
    var selectedTeamKey = document.getElementById('selectedTeamKey').value;

    if(!selectedTeamKey){
        fetchTeamNoByPrjNo(prjNo).then(function (teamNo){
            if(teamNo){
                openPopup(teamNo);
            } else{
                alert("팀 정보를 불러오지 못했습니다");
            }
        }).catch(function(error) {
            console.error("팀 정보 요청 중 에러 발생 : ", error);
            alert("팀 정보를 불러오는 중 오류 발생");
        })
    } else {
        openPopup(selectedTeamKey);
    }

}

function openPopup(teamNo){
    window.open(
        "/projects/addMember?teamNo=" + teamNo + '&prjNo=' + prjNo,
        "그룹등록",
        "width=1000, height=850, resizable=yes"
    );
}



// 최상위 팀의 팀번호
function fetchTeamNoByPrjNo(prjNo) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: '/teams', // 팀 번호를 받아오는 API 엔드포인트
            type: 'GET',
            data: {projectNo: prjNo},
            success: function (response) {
                resolve(response[0].key);
            },
            error: function (xhr, status, error) {
                console.error("teamNo 요청 실패: ", error);
                reject(error);
            }
        });
    });
}

// 팀 데이터를 불러오는 함수
async function loadTeamData(prjNo) {
    console.log("loadTeamData call");
    return new Promise((resolve, reject) => {
        $.ajax({
            url: '/teams',
            method: 'GET',
            data: { projectNo: prjNo },
            cache: false,
            success: function (response) {
                console.log("loadTeamData success");
                var treeData = response;
                renderTeamTree(treeData);  // FancyTree 초기화 함수 호출
                resolve();  // 작업 완료 후 resolve 호출
            },
            error: function (error) {
                console.error("데이터를 가져오는 중 오류 발생:", error);
                reject(error);  // 오류 발생 시 reject 호출
            }
        });
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

function setExpanded(treeData) {
    treeData.forEach(function(node) {
        node.expanded = true; // 모든 노드를 펼침 상태로 설정
        if (node.children) {
            setExpanded(node.children); // 재귀적으로 자식 노드도 펼침
        }
    });
}

function renderTeamTree(treeData) {
    console.log("트리 데이터: ", treeData);  // 트리 데이터 로그 출력

    setExpanded(treeData);  // 모든 노드를 펼친 상태로 설정

    var tree = $.ui.fancytree.getTree("#tree-table");
    if(tree){
        tree.reload(treeData);
    } else {
        $("#tree-table").fancytree({
            extensions: ["table", "dnd5", "filter", "gridnav"],
            checkbox: false,
            selectMode: 1,
            quicksearch: true,
            source: treeData,
            keyboard: true,
            focusOnSelect: true,
            autoScroll: true,
            titlesTabbable: true,
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
                    node.setExpanded();
                }
            },
            activate: function(event, data) {
                var node = data.node;
                var teamKey = node.key;
                var teamName = node.title;

                document.getElementById('selectedTeamKey').value = teamKey;

                if(node.data.parentId === null){
                    $(".team-overview, .team-members, .member-detail").hide();
                    $("#project-member-grid-section").show();
                    loadProjectMembers(prjNo);
                } else {
                    $(".team-overview, .team-members").show();
                    $("#project-member-grid-section").hide();
                    $(".member-detail").hide();
                    updateTeamInfo(node.data, teamName);
                    loadTeamMembers(teamKey);
                }

                updateTeamInfo(node.data, teamName);
                //loadTeamMembers(teamKey);
            }
        });
    }
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
        url: '/projects/' + prjNo + '/members/team/' + teamKey,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("팀원 목록 데이터:", response);

            const dataWithTeamKey = response.map(member => {
                member.teamNo = teamKey;
                if (member.endDate && member.endDate.startsWith("2999")) {
                    member.endDate = null;
                }
                if (member.preEndDate && member.preEndDate.startsWith("2999")) {
                    member.preEndDate = null;
                }
                if (member.startDate && member.startDate.startsWith("2999")) {
                    member.startDate = null;
                }
                if (member.preStartDate && member.preStartDate.startsWith("2999")) {
                    member.preStartDate = null;
                }
                return member;
            });

            teamMemberGrid.setData(dataWithTeamKey);
        },
        error: function(error) {
            console.error("팀원 목록 불러오기 실패:", error);
        }
    });
}


$(document).on("click", ".member-link", function(e) {
    e.preventDefault();
    var memberId = $(this).data("id");
    var teamNo = $(this).data("teamNo");
    loadMemberDetails(memberId);

    // var memberData = teamMemberGrid.list.find(item => item.id === memberId);
    // console.log(memberData);
    // if (memberData) {
    //     console.log("!!!!!!!!!!!!!asfasf");
    //     updateMemberDetail(memberData);
    // } else {
    //     console.log("!!!!!!!!!!!!!ffffff");
    //     loadMemberDetails(memberId);
    // }

    document.querySelector(".member-detail").scrollIntoView({ behavior: 'smooth' });
});

function loadMemberDetails(memberNo) {
    $.ajax({
        url: '/projects/' + prjNo + '/members/' + memberNo,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("memberDetail=", response);
            updateMemberDetail(response);
        },
        error: function(xhr, status, error) {
            console.error( error);
            console.error(xhr);

        }
    });
}

function formatDate(dateStr) {
    if (!dateStr || dateStr.startsWith("2999")) {
        return '-';
    }
    // yyyy-mm-dd 형식으로 변환
    return dateStr.split(' ')[0];
}


function updateMemberDetail(memberData) {
    $("#member-name").text(memberData.memberName || '-');
    $("#project-auth").text(memberData.auth || '-');
    $("#tech-grade").text(memberData.tech || '-');
    $("#position").text(memberData.position || '-');
    $("#pre-start-date").text(formatDate(memberData.preStartDate));
    $("#pre-end-date").text(formatDate(memberData.preEndDate));
    $("#start-date").text(formatDate(memberData.startDate));
    $("#end-date").text(formatDate(memberData.endDate));
    $("#email").text(memberData.email || '-');
    $("#phone-no").text(memberData.phoneNo || '-');


    const teamTable = $(".team-table");
    teamTable.empty();


    memberData.connectTeam.forEach(team => {
        const row = `<tr>
                    <td>팀명</td>
                    <td>
                        <span>${team.teamName}</span>
                    </td>
                </tr>`;
        teamTable.append(row);
    });

    $(".member-detail").show();
}


// 프로젝트 팀원 목록을 불러오는 함수
function loadProjectMembers(prjNo) {
    console.log("loadProjectMembers call");

    // 그리드가 초기화되지 않았을 경우 예외 처리
    if (!projectMemberGrid) {
        console.error("projectMemberGrid가 초기화되지 않았습니다.");
        return;
    }

    $.ajax({
        url: '/projects/projectmembersList?projectNo=' + prjNo,
        method: 'GET',
        dataType: 'json',
        cache: false,
        success: function (response) {
            console.log("loadProjectMember success");
            console.log("프로젝트 팀원 목록 데이터:", response);
            response = response.map(member => {
                // 날짜가 '2999'로 시작하면 null로 변경
                if (member.endDate && member.endDate.startsWith("2999")) {
                    member.endDate = null;
                }
                if (member.preEndDate && member.preEndDate.startsWith("2999")) {
                    member.preEndDate = null;
                }
                if (member.startDate && member.startDate.startsWith("2999")) {
                    member.startDate = null;
                }
                if (member.preStartDate && member.preStartDate.startsWith("2999")) {
                    member.preStartDate = null;
                }
                return member;
            });
            if (projectMemberGrid) {
                projectMemberGrid.setData(response);
                console.log("총인원수: " + response.length);
                $(".header1").html('<span class="member-title">인력</span> ' + (response.length || 0));
                // resolve();
            } else {
                console.error("projectMemberGrid가 초기화되지 않았습니다.");
                reject(new Error("projectMemberGrid가 초기화되지 않았습니다."));
            }},
        error: function (error) {
                console.error("프로젝트 팀원 목록 불러오기 실패:", error);
                reject(error);
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
    return loadAuthCommonCode().then(function(commonCodeOptions) {
        // teamMemberGrid 설정
        teamMemberGrid = new ax5.ui.grid();
        teamMemberGrid.setConfig({
            showRowSelector: true,
            target: $('[data-ax5grid="teamMemberGrid"]'),
            columns: [
                {key: "memberName", label: "성명", align: "center", formatter: function() {
                        return '<div class="clickable-name member-link" data-id="' + this.item.id + '" data-teamNo="' + this.item.teamNo + '" draggable="true">' + this.value + '</div>';
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
                {key: "tech", width: 75, label: "기술등급", align: "center"},
                {key: "preStartDate", width: 110, label: "예정시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year",
                                    selectMode: "day"
                                }
                            }
                        }
                    }, formatter: function() {
                        console.log(this.value);  // 디버그용
                        return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                    }},
                {key: "preEndDate", width: 110, label: "예정종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year",
                                    selectMode: "day"
                                }
                            }
                        }
                    }, formatter: function() {
                        return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                    }},
                {key: "startDate", width: 110, label: "참여시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year",
                                    selectMode: "day"
                                }
                            }
                        }
                    }, formatter: function() {
                        return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                    }},
                {key: "endDate", width: 110, label: "참여종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year",
                                    selectMode: "day"
                                }
                            }
                        }
                    }, formatter: function() {
                        return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                    }}
            ],
            onDataChanged: function() {
                // 그리드 데이터가 변경될 때마다 호출
                const updatedData = projectMemberGrid.getList("modified"); // 변경된 행 목록 가져오기
                updatedData.forEach(row => {
                    const existingRowIndex = modifiedRows.findIndex(item => item.id === row.id);
                    if (existingRowIndex === -1) {
                        modifiedRows.push(row);
                        alert("!@#");
                    } else {
                        modifiedRows[existingRowIndex] = row; // 기존 행 업데이트
                    }
                });
            },
            page: {
                display: false
            },
        });

        // projectMemberGrid 설정
        console.log(commonCodeOptions);
        if(!projectMemberGrid){
            projectMemberGrid = new ax5.ui.grid();
            projectMemberGrid.setConfig({
                showRowSelector: true,
                target: $('[data-ax5grid="projectMemberGrid"]'),
                columns: [
                    {key: "memberName", width: 85, label: "성명", align: "center", formatter: function() {
                            console.log(this.item.teamNo);
                            return '<div class="clickable-name member-link" data-id="' + this.item.id + '" data-teamNo="' +
                                this.item.teamNo + '" draggable="true">' + this.value + '</div>';
                        }},
                    {
                        key: "auth",
                        label: "프로젝트권한",
                        align: "center",
                        editor: {
                            type: "select",
                            config: {
                                columnKeys: {
                                    optionValue: "CD", // 실제 값으로 코드값을 사용
                                    optionText: "NM" // 화면에 표시할 텍스트로 코드명을 사용
                                },
                                options: commonCodeOptions
                            }
                        },
                        formatter: function() {
                            // 화면에 코드명이 표시되도록 formatter 설정
                            var selectedOption = commonCodeOptions.find(function(option) {
                                return option.CD === this.value;
                            }.bind(this));
                            return selectedOption ? selectedOption.NM : this.value;
                        }
                    },
                    {key: "groupName", width: 80, label: "소속", align: "center"},
                    {key: "position", width: 75, label: "직위", align: "center"},
                    {key: "tech", width: 75, label: "기술등급", align: "center"},
                    {key: "teamName", width: 120, label: "소속팀", align: "center", formatter: function() {
                            if (this.item.parentNo != null) {
                                return this.item.teamName;
                            } else {
                                return '-';
                            }
                    }},
                    {key: "preStartDate", width: 95, label: "예정시작일", align: "center", editor: {
                            type: "date",
                            config: {
                                content: {
                                    config: {
                                        mode: "year",
                                        selectMode: "day"
                                    }
                                }
                            }
                        }, formatter: function() {
                            return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                        }},
                    {key: "preEndDate", width: 95, label: "예정종료일", align: "center", editor: {
                            type: "date",
                            config: {
                                content: {
                                    config: {
                                        mode: "year",
                                        selectMode: "day"
                                    }
                                }
                            }
                        }, formatter: function() {
                            return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                        }},
                    {key: "startDate", width: 95, label: "참여시작일", align: "center", editor: {
                            type: "date",
                            config: {
                                content: {
                                    config: {
                                        mode: "year",
                                        selectMode: "day"
                                    }
                                }
                            }
                        }, formatter: function() {
                            return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                        }},
                    {key: "endDate", width: 95, label: "참여종료일", align: "center", editor: {
                            type: "date",
                            config: {
                                content: {
                                    config: {
                                        mode: "year",
                                        selectMode: "day"
                                    }
                                }
                            }
                        }, formatter: function() {
                            return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                        }}
                ],
                page: {
                    display: false
                }
            });
        }


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

// 팀 목록 가져오기
function loadTeamOptions(selectElementId) {
    $.ajax({
        url: '/teamsSelectOptions?projectNo=' + prjNo,
        type: 'GET',
        success: function(response) {
            console.log("팀 목록 : " + response);
            const teamSelect = $(selectElementId);
            teamSelect.empty(); // 기존 옵션 초기화
            response.forEach(function(team) {
                teamSelect.append(new Option(team.teamName, team.teamNo));
            });
        },
        error: function(xhr, status, error) {
            console.error('상위팀 데이터를 가져오는 데 실패했습니다: ', error);
        }
    });
}



function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("systems: " + response);
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

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
            $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
            $('.mymenu').slideUp();  // 메뉴 숨기기
        });

        parentElement.append(listItem);
    });
}

function getTeamFormData() {
    return {
        teamName: $('#team_title').val(),
        parentNo: $('#parent-team').val(),
        systemNo: $('#systemNo').val(),
        teamContent: $('#team_cont').val(),
        projectNo: prjNo
    };
}

function submitTeamCreation(formData) {
    $.ajax({
        url: '/teams',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function(response) {
            alert('팀이 성공적으로 생성되었습니다.');
            location.reload();
        },
        error: function(xhr, status, error) {
            console.error('팀 생성 중 오류 발생: ', error);
            alert('팀 생성 중 오류가 발생했습니다.');
        }
    });
}


function memberAssignTeam(teamNo, members, teamLoadStatus, teamLoadNo){
    console.log("memberAssignTeam");
    console.log(members);
    $.ajax({
        url: '/projects/members/team/' + teamNo,
        type: 'POST',
        contentType: 'application/json',
        cache: false,
        data: JSON.stringify(members),
        success: function (response) {
            toastNotification(response);
            loadTeamData(prjNo);
            if(teamLoadStatus === 'teamLoad'){
                loadTeamMembers(teamLoadNo);
            } else{
                loadProjectMembers(prjNo);
            }
        },
        error: function(xhr, status, error) {
            var error = xhr.responseText;
            errorMessage(error);
        }
    })
}

$('#startProject').click(function (e) {
    e.preventDefault();
    const selectedStartMembers = teamMemberGrid.getList('selected');
    const currentDate = new Date().toISOString().slice(0, 10);

    selectedStartMembers.forEach(member => {
        member.startDate = currentDate;
    });

    $.ajax({
        url: '/projects/members/date?type=start',
        method: 'POST',
        data: JSON.stringify(selectedStartMembers),
        contentType: 'application/json',
        success: function(response) {
            console.log("Start date 설정 완료:", response);
            loadTeamMembers(selectedStartMembers[0].teamNo);
            toastNotification("참여시작일 설정 완료");
        },
        error: function(error) {
            console.error("Start date 설정 실패:", error);
        }
    });

    teamMemberGrid.clearSelect();
});

$('#endProject').click(function (e) {
    e.preventDefault();
    const selectedEndMembers = teamMemberGrid.getList('selected');
    const currentDate = new Date().toISOString().slice(0, 10);

    selectedEndMembers.forEach(member => {
        member.endDate = currentDate;
    });

    $.ajax({
        url: '/projects/members/date?type=end',
        method: 'POST',
        data: JSON.stringify(selectedEndMembers),
        contentType: 'application/json',
        success: function(response) {
            console.log("End date 설정 완료:", response);
            loadTeamMembers(selectedEndMembers[0].teamNo);
            toastNotification("참여종료일 설정 완료");

        },
        error: function(error) {
            console.error("End date 설정 실패:", error);
        }
    });

    teamMemberGrid.clearSelect();
});



$('#teamMemberUpdateBtn').click(function (e) {
   const modifiedRow = teamMemberGrid.getList("modified");
   console.log("teamMember modify = ", modifiedRow);

    if (modifiedRow.length === 0) {
        toastNotification("변경된 내용이 없습니다");
        return;
    }

    $.ajax({
        url: '/projects/members',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(modifiedRow),
        success: function(response) {
            toastNotification("변경 사항이 성공적으로 저장되었습니다");
            loadTeamMembers(modifiedRow[0].teamNo);
        },
        error: function(error) {
            console.error("저장 실패:", error);
            alert("저장에 실패했습니다.");
        }
    });


});

$('#projectMemberUpdateBtn').click(function (e){
    const modifiedRow = projectMemberGrid.getList("modified");
    console.log("projectMember modify = ", modifiedRow);

    if (modifiedRow.length === 0) {
        toastNotification("변경된 내용이 없습니다");
        return;
    }

    $.ajax({
        url: '/projects/members',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(modifiedRow),
        success: function(response) {
            toastNotification("변경 사항이 성공적으로 저장되었습니다");
            loadProjectMembers(prjNo);
        },
        error: function(error) {
            console.error("저장 실패:", error);
            alert("저장에 실패했습니다.");
        }
    });
});


function toastNotification(message) {
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 2000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener("mouseenter", Swal.stopTimer);
            toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
    });

    Toast.fire({
        icon: "success",
        title: message,
    });
}


function errorMessage(message) {
    Swal.fire({
        title: "오류!",
        text: message,
        icon: "error",
        confirmButtonText: "확인",
    });
}