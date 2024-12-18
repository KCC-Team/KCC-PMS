$(document).ready(function() {
    $.jstree.defaults.core.themes.icons = false;

    function addIcons(node) {
        node.text = `<i class='fa-solid fa-users'></i> ${node.text}`;

        if (node.children && node.children.length > 0) {
            node.children = node.children.map(addIcons);  //재귀호출로 손자노드까지 아이콘 추가
        }
        return node;
    }
    //조직도 가져오기
    $.ajax({
        url: '/projects/getGroupList',
        method: 'GET',
        success: function(response) {
            const treeDataWithIcons = response.map(addIcons);
            $('#jstree').jstree({
                'core': {
                    'data': treeDataWithIcons,
                    'check_callback': true
                },
                'plugins': ["search", "dnd"]
            }).on("ready.jstree", function() {
                $(this).jstree("open_all");
            });
        },
    });

    //부서 인원 목록 가져오기
    $('#jstree').on("select_node.jstree", function (e, data) {
        const selectedNodeId = data.node.id;
        const url = new URL(window.location.href);
        const teamNo = url.searchParams.get('teamNo');
        $.ajax({
            url: "/projects/members/groups",
            type: 'GET',
            data: {
                groupNo: selectedNodeId,
                exceptTeamNo: teamNo // teamNo를 추가
            },
            success: function(members) {
                $('#selectedGroupName').text(members[0].groupName);
                reg_groupmemGrid.setData(members);
            },
            error: function(xhr, status, error) {
                console.error('인원 목록을 가져오는 데 실패했습니다: ', error);
            }
        });

        $('#memberList').children().show();
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