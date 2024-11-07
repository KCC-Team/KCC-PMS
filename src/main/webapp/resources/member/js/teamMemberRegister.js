$(document).ready(function() {
    var urlParams = new URLSearchParams(window.location.search);
    let typeValue = urlParams.get('type');
    if(typeValue === 'feature' || typeValue === 'defect1' || typeValue === 'defect2' || typeValue.includes('test_') || typeValue === 'test_unit_'){
        $('#jstree-container').css('height', '367px'); // jstree-container 높이 조절
        $('#memberList').css('height', '367px'); // memberList 높이 조절
    }

    $.jstree.defaults.core.themes.icons = false;

    function addIcons(node) {
        node.text = `<i class='fa-solid fa-users'></i> ${node.text}`;

        if (node.children && node.children.length > 0) {
            node.children = node.children.map(addIcons);  //재귀호출로 손자노드까지 아이콘 추가
        }
        return node;
    }
    //팀 트리 가져오기
    $.ajax({
        url: '/teams/tree',
        method: 'GET',
        success: function(response) {
            const treeDataWithIcons = response.map(addIcons);
            console.log("response = " + JSON.stringify(response));
            console.log("treeDataWithIcons=" + treeDataWithIcons);
            $('#jstree').jstree({
                'core': {
                    'data': treeDataWithIcons,
                    'check_callback': true
                },
                'plugins': ["search", "dnd"]
            });
            $('#jstree').on('ready.jstree', function() {
                $('#jstree').jstree('open_all');
            });
        },
    });

    //팀 인원 목록 가져오기
    $('#jstree').on("select_node.jstree", function (e, data) {
        const teamNo = data.node.id;
        console.log("teamNo = " + teamNo);
        const cleanText = $('<div>' + data.node.text + '</div>').text();

        $.ajax({
            url: "/team/" + teamNo + "/members",
            type: 'GET',
            success: function(members) {
                console.log(members);
                $('#selectedGroupName').text(cleanText);
                team_reg_groupmemGrid.setData(members);

            },
            error: function(xhr, status, error) {
                console.error('인원 목록을 가져오는 데 실패했습니다: ', error);
            }
        });

        $('#memberList').children().show();
        if(typeValue === 'feature' || typeValue === 'defect1' || typeValue === 'defect2' || typeValue.includes('test_') || typeValue === 'test_unit_'){
            $('#addedContainer').hide();
        }
    });

    // 검색 기능
    $('#search').on('keyup', function () {
        var searchString = $(this).val();
        $('#jstree').jstree(true).search(searchString);

        setTimeout(() => {
            var results = $('#jstree').jstree(true).get_json('#', { flat: true });
            var found = results.filter(node => node.text.includes(searchString));
            if (found.length > 0) {
                var firstResult = found[0];

                $('#jstree').jstree(true).deselect_all();
                $('#jstree').jstree(true).select_node(firstResult.id);

                $('#' + firstResult.id).get(0).scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }, 0);
    });

    $('#memberList').children().hide();
});