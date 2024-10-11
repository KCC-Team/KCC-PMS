<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .custom-radio {
        transform: scale(1.1);
        margin-right: 6px;
    }

    .custom-label {
        font-size: 15px;
    }

    .jstree-folder-in {
        height: 100px;
        border: 1px solid #C5C5C5;
        padding: 10px;
        overflow-y: auto;
    }
</style>

<div class="modal fade" id="folderModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: #070606; font-weight: bold">새 폴더 만들기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <section class="info-section d-flex flex-column">
                    <div>
                        <div class="jstree-folder-in">
                        </div>
                    </div>
                    <br>
                    <div class="d-flex justify-content-start">
                        <div class="fw-bold me-3"><label style="font-size: 17px;">폴더 구분</label></div>
                        <form>
                            <input type="radio" id="folder" name="type" value="folder" checked class="custom-radio" />
                            <label for="folder" class="custom-label">폴더</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" id="output" name="type" value="output" class="custom-radio" />
                            <label for="output" class="custom-label">산출물</label>
                        </form>
                    </div>
                    <br>
                    <div class="d-flex justify-content-start">
                        <div class="fw-bold me-3"><label style="font-size: 17px;">폴더명</label></div>
                        <div class="me-3">
                            <span><input id="input-area-folder" class="txt-area" type="text" /></span>
                        </div>
                        <div>
                            <button type="button" class="custom-button" id="add-folder-btn">&nbsp;&nbsp;&nbsp;추가&nbsp;&nbsp;&nbsp;</button>
                        </div>
                    </div>
                </section>
            </div>
            <div class="modal-footer">
                <button type="button" class="save-button" data-bs-dismiss="modal">&nbsp;&nbsp;저장하기&nbsp;&nbsp;</button>
            </div>
        </div>
    </div>
</div>

<script>
    let treeData = [
        {
            id: "1",
            text: "차세대 프로그램 구축",
            type: "folder",
            children: [
                {
                    id: "1.1",
                    text: "요구사항 정의서",
                    type: "output",
                },
                {
                    id: "1.2",
                    text: "요구사항추적표(설계)",
                    type: "output",
                },
            ],
        },
        {
            id: "2",
            text: "B 프로그램 구축",
            type: "folder",
            children: [
                {
                    id: "2.1",
                    text: "개발환경 설치 작업계획서",
                    type: "output",
                },
            ],
        },
    ];

    const initData = JSON.parse(JSON.stringify(treeData));

    $(function() {
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
                    "output": {
                        "icon": "fa-solid fa-box-archive text-success"
                    }
                }
            });
            $('.jstree-folder-in').jstree('refresh');
        }

        // 초기화
        initializeJsTree(treeData);
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
                type: $('#output').is(':checked') ? 'output' : 'folder'
            };

            // jsTree에 새 노드 추가
            $('.jstree-folder-in').jstree('create_node', parentNodeId, newNode, "last", function(new_node) {
                console.log("노드가 추가되었습니다:", new_node);
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

            addNodeToTreeData(treeData, parentNodeId, newNode);
            $('#input-area-folder').val('');
        });

        // 모달이 닫힐 때 트리와 입력 필드 초기화
        $('#folderModal').on('hidden.bs.modal', function () {
            $('#input-area-folder').val('');
            $('#folder').prop('checked', true);
            selectedNode = null;
            treeData = JSON.parse(JSON.stringify(initData));
            initializeJsTree(treeData);
            console.log('모달이 닫혔습니다. jsTree와 입력 필드가 초기화되었습니다.');
        });
    });
</script>
