$(document.body).ready(function () {
    var groupmemGrid;
    var prjmemGrid;
    var addedGrid;
    let isEditing = false;
    let addedMembers = [];

    function updateAddedGrid() {
        addedGrid.setData(addedMembers);
    }

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

    $('#project_member_total').on('click', function() {
        $('#add-member-by-prjmem').show();
        $('#add-member-by-group').hide();

        let $table =  $('#add-member-by-group').find('#y-added-grid');
        $('#grid-parent2').append($table);
        //updateAddedGrid();
    });

    $('#group_total').on('click', function() {
        $('#add-member-by-group').show();
        $('#add-member-by-prjmem').hide();

        let $table =  $('#grid-parent2').find('#y-added-grid');
        $('#grid-parent3').append($table);
        // updateAddedGrid();
    });


    // 편집 버튼
    $('.member-edit-button').on('click', function () {
        var currentText = $(this).text();
        console.log(currentText);
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
                    name: member.name,
                    auth: member.auth ? member.auth : "",
                    group: "SI 1팀",
                    position: member.position,
                    pre_st_dt: "",
                    pre_end_dt: "",
                    st_dt: "",
                    end_dt: "",
                    tech_grd: ""
                });
            }
        });

        updateAddedGrid(); // 추가된 멤버들을 그리드에 반영
    });


    groupmemGrid = new ax5.ui.grid();

    groupmemGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="groupmemGrid"]'),
        columns: [
            {key: "name", label: "성명", align: "center"},
            {key: "position", label: "직위", align: "center" },
            {key: "email", width: 220, label: "이메일", align: "center"},
            {key: "participate_yn", width: 70, label: "참여여부",align: "center"}

        ],
        page: {
            display: false
        }
    });
    groupmemGrid.setData([
        {id: 1, name: "이수호", position: "사원", email: "kcc1@example.com", participate_yn: "Y"},
        {id: 2, name: "김연호", position: "사원", email: "kcc2@example.com", participate_yn: "Y"},
        {id: 3, name: "이한희", position: "사원", email: "kcc3@example.com", participate_yn: "N"},
        {id: 4, name: "홍길동", position: "사원", email: "kcc4@example.com", participate_yn: "N"},
        {id: 5, name: "이수호", position: "사원", email: "kcc1@example.com", participate_yn: "Y"},
        {id: 6, name: "김연호", position: "사원", email: "kcc2@example.com", participate_yn: "Y"},
        {id: 7, name: "이한희", position: "사원", email: "kcc3@example.com", participate_yn: "N"},
        {id: 8, name: "홍길동", position: "사원", email: "kcc4@example.com", participate_yn: "N"},
        {id: 9, name: "이수호", position: "사원", email: "kcc1@example.com", participate_yn: "Y"},
        {id: 10, name: "김연호", position: "사원", email: "kcc2@example.com", participate_yn: "Y"},
        {id: 11, name: "이한희", position: "사원", email: "kcc3@example.com", participate_yn: "N"},
        {id: 12, name: "홍길동", position: "사원", email: "kcc4@example.com", participate_yn: "N"}
    ]);

    function initGrid() {
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
                                return !isEditing;
                            }
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
                                return !isEditing;
                            }
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
                            }
                        }
                    },
                    {key: "tech_grd", width: 70, label: "기술등급", align: "center"}
                ],
                page: {
                    display: false
                }
            });
        }).catch(function(error) {
            console.error("그리드 초기화 오류: ", error);
        });
    }

    initGrid();

    prjmemGrid = new ax5.ui.grid();
    prjmemGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="prjmember-grid"]'),
        columns: [
            {key: "name", label: "성명", align: "center"},
            {key: "auth", label: "프로젝트권환", align: "center"},
            {key: "group", width: 100, label: "소속", align: "center"},
            {key: "position", width: 70, label: "직위",align: "center"},
            {key: "pre_st_dt", width: 100, label: "예정시작일",align: "center"},
            {key: "pre_end_dt", width: 100, label: "예정종료일",align: "center"},
            {key: "st_dt", width: 100, label: "참여시작일",align: "center"},
            {key: "end_dt", width: 100, label: "참여종료일",align: "center"},
            {key: "tech_grd", width: 70, label: "기술등급",align: "center"}
        ],
        page: {
            display: false
        }
    });

    prjmemGrid.setData([
        {id: 101, name: "김연호", auth: "PM", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 102, name: "이수호", auth: "PL", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 103, name: "이한희", auth: "PL", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 104, name: "홍길동", auth: "팀원", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 105, name: "김연호", auth: "PM", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 106, name: "이수호", auth: "PL", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 107, name: "이한희", auth: "PL", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 108, name: "홍길동", auth: "팀원", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 109, name: "김연호", auth: "PM", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 110, name: "이수호", auth: "PL", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 111, name: "이한희", auth: "PL", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"},
        {id: 112, name: "홍길동", auth: "팀원", group: "SI 1팀", position: "차장", pre_st_dt: "2024-05-12", pre_end_dt: "2025-05-12", tech_grd: "고급"}
    ]);

    $('#add-member-by-prjmem').hide();
});