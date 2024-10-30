var reg_groupmemGrid;
var reg_prjmemGrid;
var reg_addedGrid;
let reg_isEditing = false;
let addedMembers = [];
var teamNo;
var prjNo;
$(document.body).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    teamNo = urlParams.get('teamNo');
    prjNo = urlParams.get('prjNo');

    console.log(prjNo);

    $('#project_member_total').on('click', function() {
        $('#add-member-by-prjmem').show();
        $('#add-member-by-group').hide();

        let $table =  $('#add-member-by-group').find('#y-added-grid');
        $('#grid-parent2').append($table);
    });

    $('#group_total').on('click', function() {
        $('#add-member-by-group').show();
        $('#add-member-by-prjmem').hide();

        let $table =  $('#grid-parent2').find('#y-added-grid');
        $('#grid-parent3').append($table);
    });


    // 편집 버튼
    $('.reg-member-edit-button').on('click', function () {
        var currentText = $(this).text();

        if (currentText === '편집') {
            reg_isEditing = true;
            $(this).text('저장'); // 텍스트를 '저장'으로 변경
        } else {
            reg_isEditing = false;
            $(this).text('편집'); // 텍스트를 '편집'으로 변경
        }

        // 그리드를 다시 렌더링해서 editor 상태를 반영
        reg_addedGrid.repaint();
    });


    //멤버 제거 버튼
    $('.member-remove-button').on('click', function() {
        let selectedMembers = reg_addedGrid.getList("selected");  // 추가된 목록에서 선택된 멤버 가져오기
        selectedMembers.forEach(member => {
            addedMembers = addedMembers.filter(m => m.id !== member.id);  // id 기준으로 제거
        });
        updateAddedGrid();
        // reg_addedGrid.clearSelector();
    });

    // 멤버 추가 버튼
    $('.member-add-button').on('click', function() {
        let selectedMembers;

        if($(this).parent().parent().parent().attr('id') == 'prjmem_list'){ //총 프로젝트인원 목록에서 추가하기 버튼을 눌렀다면
            selectedMembers = reg_prjmemGrid.getList("selected");
            reg_prjmemGrid.clearSelect();
        } else {
            selectedMembers = reg_groupmemGrid.getList("selected");
            reg_groupmemGrid.clearSelect();
        }

        var typeValue = urlParams.get('type');
        if (typeValue == 'project' && selectedMembers.length > 1) {
            alert("PM은 1명만 등록 가능합니다.");
            return false;
        }

        selectedMembers.forEach(member => {
            var typeValue = urlParams.get('type');
            if (typeValue == 'project') {
                member.auth = 'PMS00201'
            }

            console.log("추가된 멤버 : " + JSON.stringify(member, null, 2));

            let exists = addedMembers.some(m => m.id === member.id);
            if (!exists) {
                console.log(member.preStartDate);
                console.log(member.preEndDate);
                console.log(member.startDate);
                console.log(member.endDate);
                console.log(member.connectTeams);
                addedMembers.push({
                    id: member.id,
                    name: member.memberName,
                    auth: member.auth ? member.auth : "",
                    group: member.groupName,
                    position: member.position,
                    pre_st_dt: member.preStartDate ? member.preStartDate : "",
                    pre_end_dt: member.preEndDate ? member.preEndDate : "",
                    st_dt: member.startDate ? member.startDate : "",
                    end_dt: member.endDate ? member.endDate : "",
                    techGrade: member.tech,
                    connectTeams: member.connectTeams
                });

            }
        });

        updateAddedGrid(); // 추가된 멤버들을 그리드에 반영
    });


    // 적용 버튼 클릭
    $(document).on('click', '.apply', function() {
        insertProject();

        let typeValue = urlParams.get('type');
        let pageValue = urlParams.get('page');
        if (typeValue != 'project' && pageValue != 'wbs') {
            registerMember();
        }
    });

    initGrid();
    reg_loadProjectMember();

    //$('#add-member-by-prjmem').hide();

    checkProject();
});

function checkProject() {
    let urlParams = new URLSearchParams(window.location.search);
    let typeValue = urlParams.get('type');
    // if (typeValue === 'project') {
    //     document.getElementById('project_member_total').hidden = true;
    // }
    if (typeValue === 'wbs') {
        //document.getElementById('group_total').hidden = true;
        $('#project_member_total').trigger('click');
    }
}

function insertProject() {
    var urlParams = new URLSearchParams(window.location.search);
    var typeValue = urlParams.get('type');

    if (window.opener && (typeValue === 'project' || typeValue === 'wbs')) {
        if (typeValue === 'project' && addedMembers[0].auth != 'PMS00201') {
            alert("PM만 등록 가능합니다.")
            return false;
        }
        window.opener.postMessage(addedMembers);
        window.close();
    } else {
        console.log("부모 창을 인식하지 못했습니다.");
    }
}


function updateAddedGrid() {
    reg_addedGrid.setData(addedMembers);
}

function reg_loadProjectMember() {
    //프로젝트 총인원
    $.ajax({
        url: '/projects/projectmembers?projectNo=' + prjNo,
        method: 'GET',
        success: function(response) {
            console.log("reg_loadProjectMember success" + response);
            reg_prjmemGrid.setData(response);
        },
        error: function(error) {
            console.error("팀원 목록 불러오기 실패:", error);
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
    reg_groupmemGrid = new ax5.ui.grid();
    reg_groupmemGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="groupmemGrid"]'),
        columns: [
            {key: "memberName", label: "성명", align: "center"},
            {key: "position", label: "직위", align: "center" },
            {key: "email", width: 220, label: "이메일", align: "center"},
            {key: "participate_yn", width: 70, label: "참여여부",align: "center"},
            {key: "tech", width: 70, label: "기술등급",align: "center"}
        ],
        page: {
            display: false
        }
    });


    reg_prjmemGrid = new ax5.ui.grid();
    reg_prjmemGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="prjmember-grid"]'),
        columns: [
            {key: "memberName", label: "성명", align: "center"},
            {key: "auth", label: "프로젝트권한", align: "center"},
            {key: "groupName", width: 90, label: "소속", align: "center"},
            {key: "position", width: 80, label: "직위", align: "center"},
            {key: "tech", width: 80, label: "기술등급", align: "center"},
            {key: "teamName", width: 110, label: "소속팀", align: "center", formatter: function() {
                    // connectedTeams을 탐색하면서 소속된 팀들 모두 가져옴
                    if (this.item.connectTeams && this.item.connectTeams.length > 0) {
                        // 소속팀이 하나뿐이고 parentNo이 null인 경우
                        if (this.item.connectTeams.length === 1 && this.item.connectTeams[0].parentNo === null) {
                            return '-'; // 소속팀이 없음을 표시
                        }
                        return this.item.connectTeams.map(function(team) {
                            return team.teamName;
                        }).join(', '); // 팀 이름을 ', '로 구분하여 표시
                    } else {
                        return '-';
                    }
            }},
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
                    return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                }},
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
                },formatter: function() {
                    return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                }},
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
                    return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                }},
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
                    return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                }},
        ],
        page: {
            display: false
        }
    });

    loadAuthCommonCode().then(function(commonCodeOptions) {
        reg_addedGrid = new ax5.ui.grid();
        reg_addedGrid.setConfig({
            showRowSelector: true,
            target: $('[data-ax5grid="added-grid"]'),
            columns: [
                {key: "name", label: "성명", align: "center"},
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
                            return !reg_isEditing;
                        }
                    },
                    formatter: function() {
                        var selectedOption = commonCodeOptions.find(function(option) {
                            return option.CD === this.value;
                        }.bind(this));
                        return selectedOption ? selectedOption.NM : this.value;
                    }
                },
                {key: "group", width: 100, label: "소속", align: "center"},
                {key: "position", width: 70, label: "직위", align: "center"},
                {key: "pre_st_dt", width: 100, label: "예정시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !reg_isEditing;
                        }
                    },
                    formatter: function() {
                        return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                    }
                },
                {key: "pre_end_dt", width: 100, label: "예정종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !reg_isEditing;
                        }
                    },
                    formatter: function() {
                        return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                    }
                },
                {key: "st_dt", width: 100, label: "참여시작일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !reg_isEditing;
                        }},
                        formatter: function() {
                            console.log(this.value);
                            return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                        }

                },
                {key: "end_dt", width: 100, label: "참여종료일", align: "center", editor: {
                        type: "date",
                        config: {
                            content: {
                                config: {
                                    mode: "year", selectMode: "day"
                                }
                            }
                        },
                        disabled: function () {
                            return !reg_isEditing;
                        }},
                        formatter: function() {
                            return this.value && this.value.substring(0, 10) !== '2999-12-31' ? this.value.substring(0, 10) : '-';
                        }

                },
                {key: "techGrade", width: 70, label: "기술등급", align: "center"}
            ],
            page: {
                display: false
            }
        });
    }).catch(function(error) {
        console.error("그리드 초기화 오류: ", error);
    });
}


async function registerMember() {
    var addedGridData = reg_addedGrid.getList();
    console.log("Registering members...");

    let unassignedMembers = [];  // 어느팀에도 소속되지 않은 데이터
    let assignedMembers = [];    // 1개의 팀이라도 소속되어 있는 데이터

    console.log("register call addedMembers" + addedMembers);
    loadAuthCommonCode().then(async function(commonCodeOptions) {
        addedMembers.map(function(member) {
            console.log(JSON.stringify(member));
            var authCode = member.auth;
            var selectedOption = commonCodeOptions.find(function(option) {
                return option.NM === authCode;
            });
            if (selectedOption) {
                authCode = selectedOption.CD;
            }

            let memberData = {
                id: member.id,
                auth: authCode,
                pre_st_dt: member.preStartDate ? member.preStartDate : null,
                pre_end_dt: member.preEndDate ? member.preEndDate : null,
                st_dt: member.startDate ? member.startDate : null,
                end_dt: member.endDate ? member.endDate : null,
                connectFirstTeamNo: member.connectTeams ? member.connectTeams[0].teamNo : null
            };

            if (member.connectTeams && member.connectTeams.length === 1 && member.connectTeams[0].parentNo === null) {
                unassignedMembers.push(memberData);
            } else {
                assignedMembers.push(memberData);
            }
        });

        try {
            let assignedMembersPromise = Promise.resolve();  // 기본값으로 비어있는 Promise 생성

            if (assignedMembers.length > 0) {
                assignedMembersPromise = $.ajax({
                    url: '/team/' + teamNo + '/members?prjNo=' + prjNo,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(assignedMembers),
                    success: function (response) {
                        console.log("등록된 팀원 수 : " + response);
                        console.log("팀원 등록 성공");
                    },
                });
            }

            let unassignedMembersPromise = Promise.resolve();  // 기본값으로 비어있는 Promise 생성

            if (unassignedMembers.length > 0) {
                // 모든 비배정 팀원의 팀 배정 요청을 저장할 배열
                const requests = unassignedMembers.map(memberData => {
                    console.log("update" + memberData.id);
                    console.log("update beforeteamno" + memberData.connectFirstTeamNo);
                    console.log("update teamNo" + teamNo);
                    return $.ajax({
                        url: '/projects/members/' + memberData.id + '/team/' + teamNo,
                        type: 'PATCH',
                        contentType: 'application/json',
                        cache: false,
                        data: JSON.stringify({
                            beforeTeamNo: memberData.connectFirstTeamNo
                        })
                    });
                });

                unassignedMembersPromise = Promise.all(requests);
            }

            // 두 비동기 작업이 모두 완료되었을 때 closePopupAndUpdateParent 실행
            await Promise.all([assignedMembersPromise, unassignedMembersPromise]);
            alert('모든 작업이 성공적으로 완료되었습니다');
            closePopupAndUpdateParent();  // 완료 후 부모 페이지 업데이트 및 팝업 닫기

        } catch (error) {
            console.error("오류 발생:", error);
            alert('팀원 등록에 실패하였습니다.');
        }
    }).catch(function(error) {
        console.error("공통 코드 로드 오류: ", error);
        alert("프로젝트 권한 코드를 가져오는 중 오류가 발생했습니다.");
    });
}


function closePopupAndUpdateParent() {
    // 부모 페이지로 메시지 전달
    window.opener.postMessage({ type: 'updateTree', teamNo: teamNo }, '*');
    console.log("부모 페이지 업데이트 메시지 전송 완료. 팝업 닫기.");
    window.close();  // 팝업 닫기
}


function openTab(selectedTab) {
    var tabs = document.querySelectorAll('.tab-btn');
    tabs.forEach(function(tab) {
        tab.classList.remove('active');
    });
    selectedTab.classList.add('active');
}