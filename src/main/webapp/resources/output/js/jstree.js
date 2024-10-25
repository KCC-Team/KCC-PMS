$(function() {
    $.ajax({
        url: '/projects/outputs/api/list?option=y',
        type: 'GET',
        success: function(data) {
            window.treeFolderData = data;
            let jsTreeData = convertToJsTreeData(window.treeFolderData);
            window.jsTreeInstance = $('.jstree-folder').jstree({
                'core': {
                    'data': jsTreeData,
                    "themes" : { "stripes" : true },
                    'check_callback': true
                },
                'plugins': ["types", "dnd", "wholerow", "search"],
                'types': {
                    "default": {
                        "icon": "fa fa-folder text-warning"
                    },
                    "n": {
                        "icon": "fa fa-file text-info"
                    },
                }
            });

            $(function() {
                // 초기 상태에서 드래그 앤 드롭 비활성화
                $('.jstree-files').jstree(true).settings.dnd.is_draggable = function () {
                    return false;
                };
                function initializeJsTree(data) {
                    if ($('.jstree-folder-in').jstree(true)) {
                        $('.jstree-folder-in').jstree('destroy');
                    }
                    $('.jstree-folder-in').jstree({
                        'core': {
                            'data': data,
                            "themes" : { "stripes" : true },
                            'check_callback': true
                        },
                        'plugins': ["types", "dnd", "wholerow", "search"],
                        'types': {
                            "default": {
                                "icon": "fa fa-folder text-warning"
                            },
                        }
                    });
                    $('.jstree-folder-in').jstree('refresh');
                }

                // 초기화
                initializeJsTree(window.treeData);
                let selectedNode = null;

                // 노드 선택 이벤트
                $('.jstree-folder-in').on("select_node.jstree", function (e, data) {
                    selectedNode = data.node;
                });

                // 노드 추가 버튼 클릭 이벤트
                $('#add-folder-btn').on('click', function(e) {
                    e.preventDefault();

                    let folderName = $('#input-area-folder').val().trim();
                    if (folderName === '') {
                        console.log('폴더명을 입력해주세요.');
                        alert('폴더명을 입력해주세요.');
                        return;
                    }

                    if (!selectedNode) {
                        console.log('노드를 선택해주세요.');
                        alert('노드를 선택해주세요.');
                        return;
                    }

                    // 선택된 노드를 부모로 설정
                    let parentNodeId = selectedNode.id;

                    // 새 노드 ID 생성 (고유 ID 생성 방식 필요)
                    let newNodeId = parentNodeId + '.' + (selectedNode.children.length + 1);

                    let newNode = {
                        id: newNodeId,
                        text: folderName,
                        type: 'folder'
                    };

                    // jsTree에 새 노드 추가
                    $('.jstree-folder-in').jstree('create_node', parentNodeId, newNode, "last", function(new_node) {
                        $('.jstree-folder-in').jstree('deselect_all', true);
                        $('.jstree-folder-in').jstree('select_node', new_node);
                        $('.jstree-folder-in').jstree('open_node', parentNodeId);
                    });

                    // treeData 업데이트
                    function addNodeToTreeData(data, parentId, newNode) {
                        for (let node of data) {
                            if (node.id === parentId) {
                                if (!node.children) {
                                    node.children = [];
                                }
                                node.children.push(newNode);
                                return true;
                            }
                            if (node.children && node.children.length > 0) {
                                if (addNodeToTreeData(node.children, parentId, newNode)) {
                                    return true;
                                }
                            }
                        }
                        return false;
                    }

                    addNodeToTreeData(window.treeData, parentNodeId, newNode);
                    $('#input-area-folder').val('');
                });

                $('#folderModal').on('hidden.bs.modal', function () {
                    $('#input-area-folder').val('');
                    $('#folder').prop('checked', true);
                    selectedNode = null;
                    window.treeData = JSON.parse(JSON.stringify(data));
                    initializeJsTree(window.treeData);
                });
            });
        },
        error: function() {
            alert('트리 데이터를 가져오는데 실패했습니다.');
        }
    });

    $.ajax({
        url: '/projects/outputs/api/list',
        type: 'GET',
        success: function(data) {
            window.treeData = data;
            let jsTreeFolderData = convertToJsTreeData(treeData);
            window.jsTreeFolderInstance = $('.jstree-files').jstree({
                'core': {
                    'data': jsTreeFolderData,
                    "themes" : { "stripes" : true },
                    'check_callback': true
                },
                'plugins': ["types", "dnd", "wholerow", "search"],
                'types': {
                    "default": {
                        "icon": "fa fa-folder text-warning"
                    },
                    "n": {
                        "icon": "fa fa-file text-info"
                    },
                }
            });
        },
        error: function() {
            alert('트리 데이터를 가져오는데 실패했습니다.');
        }
    });

    function convertToJsTreeData(nodes, parentId) {
        let jsTreeData = [];
        nodes.forEach(function(node) {
            let jsTreeNode = {
                id: node.id,
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
});
