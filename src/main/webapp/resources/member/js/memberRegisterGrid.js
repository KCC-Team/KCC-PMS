var groupmemGrid;
var prjmemGrid;
var addedGrid;
let isEditing = false;
let addedMembers = [];
$(document.body).ready(function () {
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
        addedGrid.repaint();
    });


    //멤버 제거 버튼
    $('.member-remove-button').on('click', function() {
        let selectedMembers = addedGrid.getList("selected");  // 추가된 목록에서 선택된 멤버 가져오기
        selectedMembers.forEach(member => {
            addedMembers = addedMembers.filter(m => m.id !== member.id);  // id 기준으로 제거
        });
        updateAddedGrid();
        addedGridMembers.clearSelector();
    });

    // 멤버 추가 버튼
    $('.member-add-button').on('click', function() {
        let selectedMembers;

        if($(this).parent().parent().parent().attr('id') == 'prjmem_list'){ //총 프로젝트인원 목록에서 추가하기 버튼을 눌렀다면
            selectedMembers = prjmemGrid.getList("selected");
            prjmemGrid.clearSelect();
        } else {
            selectedMembers = groupmemGrid.getList("selected");
            groupmemGrid.clearSelect();
        }

        selectedMembers.forEach(member => {
            let exists = addedMembers.some(m => m.id === member.id);
            if (!exists) {
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
                    techGrade: member.tech
                });
            }
        });

        updateAddedGrid(); // 추가된 멤버들을 그리드에 반영
    });



    // 적용 버튼 클릭
    $('#apply').on('click', function() {
        insertProject();
    });

    initGrid();
    loadProjectMember();

    $('#add-member-by-prjmem').hide();
});

checkProject();

function checkProject() {
    let urlParams = new URLSearchParams(window.location.search);
    let typeValue = urlParams.get('type');
    if (typeValue === 'project') {
        document.getElementById('project_member_total').hidden = true;
    }
}

function insertProject() {
    let urlParams = new URLSearchParams(window.location.search);
    let typeValue = urlParams.get('type');
    if (typeValue === 'project') {
        if (window.opener) {
            if (addedMembers.length > 1) {
                alert("PM은 1명만 등록이 가능합니다.")
                return false;
            }
            window.opener.postMessage(addedMembers, "http://localhost:8085");
            window.close();
        } else {
            console.log("부모 창을 인식하지 못했습니다.");
        }
    }
}


function updateAddedGrid() {
    addedGrid.setData(addedMembers);
}

function loadProjectMember() {
    //프로젝트 총인원
    $.ajax({
        url: '/projects/projectmembers',
        method: 'GET',
        data: {
            projectNo: 1
        },
        success: function(response) {
            prjmemGrid.setData(response);
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
    groupmemGrid = new ax5.ui.grid();
    groupmemGrid.setConfig({
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


    prjmemGrid = new ax5.ui.grid();
    prjmemGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="prjmember-grid"]'),
        columns: [
            {key: "memberName", label: "성명", align: "center"},
            {key: "auth", label: "프로젝트권환", align: "center"},
            {key: "groupName", width: 100, label: "소속", align: "center"},
            {key: "position", width: 70, label: "직위",align: "center"},
            {key: "preStartDate", width: 100, label: "예정시작일",align: "center",formatter: function() {
                    return this.value ? this.value.substring(0, 10) : '';}},
            {key: "preEndDate", width: 100, label: "예정종료일",align: "center",formatter: function() {
                    return this.value ? this.value.substring(0, 10) : '';}},
            {key: "startDate", width: 100, label: "참여시작일",align: "center",formatter: function() {
                    return this.value ? this.value.substring(0, 10) : '';}},
            {key: "endDate", width: 100, label: "참여종료일",align: "center",formatter: function() {
                    return this.value ? this.value.substring(0, 10) : '';}},
            {key: "tech", width: 70, label: "기술등급",align: "center"}
        ],
        page: {
            display: false
        }
    });

    loadAuthCommonCode().then(function(commonCodeOptions) {
        addedGrid = new ax5.ui.grid();
        addedGrid.setConfig({
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
                            return !isEditing;
                        }
                    },
                    formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}
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
                            return !isEditing;
                        }
                    },
                    formatter: function() {
                        return this.value ? this.value.substring(0, 10) : '';}
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
                            return !isEditing;
                        },
                        formatter: function() {
                            return this.value ? this.value.substring(0, 10) : '';}
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
                            return !isEditing;
                        },
                        formatter: function() {
                            return this.value ? this.value.substring(0, 10) : '';}
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