var team_reg_groupmemGrid;
var team_reg_addedGrid;
let addedMembers = [];
var teamNo;
var prjNo;
$(document.body).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    teamNo = urlParams.get('teamNo');
    prjNo = urlParams.get('prjNo');


    let typeValue = urlParams.get('type');
    if(typeValue === 'feature' || typeValue === 'defect1' || typeValue === 'defect2' || typeValue.includes('test_') || typeValue === 'test_unit_'){
        $('#grid-parent3').hide();
        $('#grid-parent').css('height', '250px');
        $('.member-add-button').on('click', function() {
            console.log("feature에서 불러운 경우 추가버튼 클릭");
            let selectedMember;
            selectedMember = team_reg_groupmemGrid.getList("selected");
            console.log("selectedMember = " + selectedMember);

            if (selectedMember.length > 1) {
                alert("1명만 선택 가능합니다.");
                return;
            }

            if (window.opener) {
                if (typeValue === 'defect1' || typeValue === 'defect2' || typeValue.includes('test_')) {
                    window.opener.postMessage({ type: typeValue, member: selectedMember }, "*");
                } else {
                    window.opener.postMessage({ type: 'featureMember', member: selectedMember }, "*");
                }
                window.close();
            } else {
                console.log("부모 페이지가 없습니다.");
            }
        });
    } else {
        // 멤버 추가 버튼
        $('.member-add-button').on('click', function() {
            let selectedMembers;


            selectedMembers = team_reg_groupmemGrid.getList("selected");
            team_reg_groupmemGrid.clearSelect();


            selectedMembers.forEach(member => {
                console.log("추가된 멤버 : " + JSON.stringify(member, null, 2));

                let exists = addedMembers.some(m => m.id === member.id);
                if (!exists) {
                    addedMembers.push({
                        id: member.id,
                        memberName: member.memberName,
                        auth: member.auth ? member.auth : "",
                        groupName: member.groupName,
                        position: member.position,
                        tech: member.tech,
                        email: member.email,
                        teamNo: member.teamNo
                    });
                    console.log("addedMembers = " + addedMembers);
                }
            });

            updateAddedGrid(); // 추가된 멤버들을 그리드에 반영
        });
    }

    //멤버 제거 버튼
    $('.member-remove-button').on('click', function() {
        let selectedMembers = team_reg_addedGrid.getList("selected");  // 추가된 목록에서 선택된 멤버 가져오기
        selectedMembers.forEach(member => {
            addedMembers = addedMembers.filter(m => m.id !== member.id);  // id 기준으로 제거
        });
        updateAddedGrid();
        // reg_addedGrid.clearSelector();
    });




    // 적용 버튼 클릭
    $(document).on('click', '.apply', function() {
        insertProject();
    });

    initGrid(typeValue);
    checkProject();

    $('#jstree').on("ready.jstree", function(e, data) {
        // jstree가 준비된 후 첫 번째 노드 선택
        let firstNode = $('#jstree').jstree(true).get_node('#').children[0]; // 첫 번째 자식 노드의 ID
        if (firstNode) {
            // 첫 번째 노드를 선택하고 select_node 이벤트 트리거
            $('#jstree').jstree(true).select_node(firstNode);
            $('#jstree').trigger('select_node.jstree', { node: $('#jstree').jstree(true).get_node(firstNode) });
        }
    });

});

function checkProject() {
    let urlParams = new URLSearchParams(window.location.search);
    let typeValue = urlParams.get('type');
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
    team_reg_addedGrid.setData(addedMembers);
}



function initGrid(typeValue) {
    var multiple = true;
    var headerSelect = true;
    if(typeValue === 'feature' || typeValue === 'defect1' || typeValue === 'defect2' || typeValue.includes('test_') || typeValue === 'test_unit_'){
         multiple = false;
         headerSelect = false;
    }
    team_reg_groupmemGrid = new ax5.ui.grid();
    team_reg_groupmemGrid.setConfig({
        showRowSelector: true,
        multipleSelect: multiple,
        header: {
            selector: headerSelect
        },
        target: $('[data-ax5grid="team-groupmemGrid"]'),
        columns: [
            {key: "memberName", label: "성명", align: "center"},
            {key: "auth", label: "프로젝트권한", align: "center"},
            {key: "groupName", width: 110, label: "소속", align: "center"},
            {key: "position", width: 80, label: "직위", align: "center"},
            {key: "tech", width: 80, label: "기술등급", align: "center"},
            {key: "email", width: 160, label: "이메일", align: "center"}
        ],
        page: {
            display: false
        }
    });


    team_reg_addedGrid = new ax5.ui.grid();
    team_reg_addedGrid.setConfig({
        showRowSelector: true,
        target: $('[data-ax5grid="team-added-grid"]'),
        columns: [
            {key: "memberName", label: "성명", align: "center"},
            {key: "auth", label: "프로젝트권한", align: "center"},
            {key: "groupName", width: 110, label: "소속", align: "center"},
            {key: "position", width: 80, label: "직위", align: "center"},
            {key: "tech", width: 80, label: "기술등급", align: "center"},
            {key: "email", width: 160, label: "이메일", align: "center"},
        ],
        page: {
            display: false
        }
    });
    console.log("init Grid Finish");
 }

// $('[data-ax5grid="team-groupmemGrid"]').on("click", ".checkBox", function () {
//     team_reg_groupmemGrid.clearSelect();  // 기존 선택 해제
//     var rowIndex = $(this).closest('[data-ax5grid-tr-data-index]').data("ax5grid-tr-data-index");
//     team_reg_groupmemGrid.select(rowIndex);  // 현재 클릭한 항목 선택
// });

function closePopupAndUpdateParent() {
    // 부모 페이지로 메시지 전달
    window.opener.postMessage({ type: 'updateTree', teamNo: teamNo }, '*');
    console.log("부모 페이지 업데이트 메시지 전송 완료. 팝업 닫기.");
    window.close();  // 팝업 닫기
}


function openTab(event, tabName) {
    // 모든 탭 콘텐츠 숨기기
    var tabContents = document.getElementsByClassName("tab-content");
    for (var i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
        tabContents[i].classList.remove("active");
    }

    // 모든 탭 버튼의 active 클래스 제거
    var tabBtns = document.getElementsByClassName("tab-btn");
    for (var i = 0; i < tabBtns.length; i++) {
        tabBtns[i].classList.remove("active");
    }
}