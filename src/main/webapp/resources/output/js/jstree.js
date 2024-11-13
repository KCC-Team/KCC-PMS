let modalTreeData;
let id;
let addedFolders = [];
let toast = new ax5.ui.toast({
    containerPosition: "top-right",
});

$(function() {
    setToast();

    // 검색 기능 설정
    var to = false;
    $('#searchFolder').keyup(function () {
        if (to) { clearTimeout(to); }
        to = setTimeout(function () {
            var v = $('#searchFolder').val();
            $('.jstree-folder-in').jstree(true).search(v);
        }, 250);
    });

    $.ajax({
        url: '/projects/outputs/api/list',
        type: 'GET',
        success: function (data) {
            window.treeData = data;
            let jsTreeFolderData = convertToJsTreeData(treeData);
            window.jsTreeFolderInstance = $('.jstree-files').jstree({
                'core': {
                    'data': jsTreeFolderData,
                    "themes": {"stripes": true},
                    'check_callback': true
                },
                'plugins': ["types", "dnd", "wholerow", "search"],
                'search': {
                    'show_only_matches': true,
                    'show_only_matches_children': true
                },
                'types': {
                    "default": {
                        "icon": "fa fa-folder text-warning"
                    },
                    "n": {
                        "icon": "fa fa-file text-info"
                    },
                }
            });
            id = findMaxId(window.treeData[0]);
            $('.jstree-files').jstree(true).settings.dnd.is_draggable = function () {
                return false;
            };
        },
        error: function () {
            toast.push({
                theme: 'danger',
                msg: '트리 데이터를 가져오는데 실패했습니다.',
                closeIcon: '<i class="fa fa-times"></i>'
            });
        }
    });

    $.ajax({
        url: '/projects/outputs/api/list?option=y',
        type: 'GET',
        success: function (data) {
            window.treeFolderData = data;
            let jsTreeData = convertToJsTreeData(window.treeFolderData);
            window.jsTreeInstance = $('.jstree-folder').jstree({
                'core': {
                    'data': jsTreeData,
                    "themes": {"stripes": true},
                    'check_callback': true
                },
                'plugins': ["types", "dnd", "wholerow", "search"],
                'search': {
                    'show_only_matches': true,
                    'show_only_matches_children': true
                },
                'types': {
                    "default": {
                        "icon": "fa fa-folder text-warning"
                    },
                    "n": {
                        "icon": "fa fa-file text-info"
                    },
                }
            });

            // 모달 내에서 사용하는 트리 데이터 초기화
            modalTreeData = JSON.parse(JSON.stringify(window.treeFolderData));
            initializeJsTree(modalTreeData);

            $('.jstree-folder-in').jstree(true).settings.dnd.is_draggable = function () {
                return false;
            };

            // 노드 선택 이벤트
            let selectedFolder;
            $('.jstree-folder-in').on("select_node.jstree", function (e, data) {
                selectedFolder = data.node;
            });

            // 노드 추가 버튼 클릭 이벤트
            $('#add-folder-btn').on('click', function (e) {
                e.preventDefault();

                let folderName = $('#input-area-folder').val().trim();
                if (folderName === '') {
                    toast.push({
                        theme: 'warning',
                        msg: '폴더 이름을 입력해주세요.',
                        closeIcon: '<i class="fa fa-times"></i>'
                    });
                    return;
                }

                if (!selectedFolder) {
                    toast.push({
                        theme: 'warning',
                        msg: '폴더를 추가할 위치를 선택해주세요.',
                        closeIcon: '<i class="fa fa-times"></i>'
                    });
                    return;
                }

                let parentNodeId = $('.jstree-folder-in').jstree('get_selected')[0];
                id++;
                let newNode = {
                    id: id,
                    text: folderName,
                    type: 'y',
                    newNode: true
                };
                addedFolders.push(newNode.id);

                // jsTree에 새 노드 추가
                $('.jstree-folder-in').jstree('create_node', parentNodeId, newNode, "last", function (new_node) {
                    $('.jstree-folder-in').jstree('deselect_all', true);
                    $('.jstree-folder-in').jstree('select_node', new_node);
                    $('.jstree-folder-in').jstree('open_node', parentNodeId);
                });

                $('#input-area-folder').val('');
            });

            // 모달 닫힘 이벤트
            $('#folderModal').on('hidden.bs.modal', function () {
                $('#input-area-folder').val('');
                $('#folder').prop('checked', true);

                // 모달 내 데이터 초기화
                modalTreeData = JSON.parse(JSON.stringify(window.treeFolderData));
                initializeJsTree(modalTreeData);

                // addedFolders 초기화
                addedFolders = [];
            });
        },
        error: function () {
            toast.push({
                theme: 'danger',
                msg: '트리 데이터를 가져오는데 실패했습니다.',
                closeIcon: '<i class="fa fa-times"></i>'
            });
        }
    });

    // 삭제된 노드와 하위 노드의 총 개수를 계산하는 함수
    function getTotalNodeCount(node) {
        let count = 1;
        if (node.children && node.children.length > 0) {
            node.children.forEach(function(childId) {
                let childNode = $('.jstree-folder-in').jstree('get_node', childId);
                count += getTotalNodeCount(childNode);
            });
        }
        return count;
    }

// 삭제된 노드와 하위 노드의 모든 ID를 가져오는 함수
    function getAllNodeIds(node) {
        let ids = [parseInt(node.id)];
        if (node.children && node.children.length > 0) {
            node.children.forEach(function(childId) {
                let childNode = $('.jstree-folder-in').jstree('get_node', childId);
                ids = ids.concat(getAllNodeIds(childNode));
            });
        }
        return ids;
    }
});

function convertToJsTreeData(nodes, parentId) {
    let jsTreeData = [];
    nodes.forEach(function(node) {
        let jsTreeNode = {
            id: node.id.toString(),
            parent: parentId || '#',
            text: node.text,
            type: node.type,
            state: {
                opened: true
            }
        };
        jsTreeData.push(jsTreeNode);
        if (node.children && node.children.length > 0) {
            jsTreeData = jsTreeData.concat(convertToJsTreeData(node.children, node.id));
        }
    });
    return jsTreeData;
}

function initializeJsTree(treeData) {
    $('.jstree-folder-in').jstree({
        'core': {
            'data': convertToJsTreeData(treeData),
            "themes": {"stripes": true},
            'check_callback': true,
        },
        'plugins': ["types", "dnd", "wholerow", "search"],
        'search': {
            'show_only_matches': true,
            'show_only_matches_children': true
        },
        'types': {
            "default": {
                "icon": "fa fa-folder text-warning"
            },
        }
    });
    $('.jstree-folder-in').jstree('refresh');
}

function setToast() {
    toast.setConfig({
        containerPosition: "top-right",
        displayTime: 3000,
        animateTime: 500,
        toastWidth: 300,
        icon: '<i class="fa fa-bell"></i>',
        closeIcon: '<i class="fa fa-times"></i>'
    });
}

function reassignIds() {
    // ID 재할당
    addedFolders.forEach((folder, index) => {
        let oldId = folder.id;
        folder.id = (index + 1).toString();

        // jsTree에서 노드 ID 업데이트
        let node = $('.jstree-folder-in').jstree('get_node', oldId);
        if (node) {
            node.id = folder.id;
            $('.jstree-folder-in').jstree('set_id', node, folder.id);
        }
    });
    id = Math.max(...addedFolders);
}

function findMaxId(node) {
    let maxId = parseInt(node.id);
    if (node.children) {
        node.children.forEach(child => {
            const childMaxId = findMaxId(child);
            if (childMaxId > maxId) {
                maxId = childMaxId;
            }
        });
    }
    return maxId;
}
