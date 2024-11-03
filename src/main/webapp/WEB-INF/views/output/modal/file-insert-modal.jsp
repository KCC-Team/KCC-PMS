<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" />

<meta charset="UTF-8">
<style>
    .modal-content-in {
        background-color: #F6F6F6;
    }

    .note-area textarea, .txt-area {
        resize: none !important;
    }

    .modal-dialog-in {
        max-width: 800px !important;
        margin: auto;
    }

    .modal-body-in .info-section {
        margin-bottom: 20px;
    }

    .modal-body-in .info-item {
        min-width: 330px !important;
    }

    .modal-body-in .info-item label {
        flex: 0 0 50px;
        margin: 0;
        color: #070606;
        font-weight: bolder;
        font-size: 15px;
    }

    .modal-body-in .info-section span {
        font-size: 15px;
    }

    .modal-body-in .txt-area {
        padding: 4px;
        font-size: 17px;
        width: 240px;
        height: 35px;
        overflow-y: hidden;
    }

    .modal-body-in .jstree-div {
        border: 1px solid #ced4da;
    }

    .modal-body-in .file-zone .select-box {
        margin-left: 20px;
        width: 250px;
        height: 150px;
        padding: 10px;
        overflow-y: auto;
    }

    .modal-body-in .file-zone .dropzone {
        border-radius: 5px;
        width: 100%;
        min-height: 30px !important;
        max-height: 60px;
    }

    .modal-body-in .file-zone .dropzone .dz-message {
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .modal-body-in.file-zone .dropzone-preview .dz-preview {
        width: 150px;
        margin: 5px;
    }

    .modal-body-in .file-zone  .dropzone-preview .dz-preview .dz-filename {
        font-size: 12px;
        width: 200px;
    }

    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-size,
    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-error-message {
        font-size: 10px;
    }

    .modal-body-in .file-zone .dropzone-preview li.dz-preview {
        width: 100%;
        margin: 5px 0;
    }

    .modal-body-in .file-zone .dropzone-preview .dz-preview {
        width: 100%;
    }

    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-image {
        flex: 0 0 auto;
        margin-right: 15px;
    }

    .modal-body-in .file-zone .dz-image img {
        width: 40px !important;
        height: 40px;
    }

    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-details {
        flex: 1 1 auto;
        overflow: hidden;
    }

    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-remove {
        flex: 0 0 auto;
        margin-left: 15px;
    }

    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-filename,
    .modal-body-in .file-zone .dropzone-preview .dz-preview .dz-size {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .modal-body-in .file-zone .file-section {
        height: 398px;
        border: 1px solid #C5C5C5;
        padding: 10px;
        overflow-y: auto;
    }

    .modal-body-in .jstree-folder {
        height: 100px;
        border: 1px solid #C5C5C5;
        padding: 10px;
        overflow-y: auto;
    }
</style>
<form id="outputForm">
    <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-in modal-dialog-centered">
            <div class="modal-content modal-content-in">
                <div class="modal-header">
                    <h5 class="modal-title" id="fileModalLabel" style="color: #070606; font-weight: bold">새 산출물 등록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body modal-body-in">
                    <section class="info-section">
                        <div class="d-flex justify-content-between">
                            <section class="info-item p-2 me-3">
                                <div class="me-5">
                                    <div><label class="text-nowrap">제목&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                    <span><textarea name="title" class="txt-area" style="width: 320px"></textarea></span>
                                </div>
                                <div class="info-item d-flex flex-column align-items-start">
                                    <div>
                                        <br>
                                        <div><label>파일 위치&nbsp;&nbsp;&nbsp;<label class="es-star">*</label></label></div>
                                        <div><span class="file-loc" style="font-size: 13px"></span>&nbsp;&nbsp;</div>
                                        <div class="jstree-div" style="width: 325px!important; height: 400px">
                                            <jsp:include page="../jstree-folder.jsp" />
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="file-zone w-100 p-2">
                                <div class="note-area">
                                    <div><label class="text-nowrap">비고</label></div>
                                    <span><textarea name="note" class="txt-area" style="width: 400px; height: 95px"></textarea></span>
                                </div>
                                <div class="file-section">
                                    <div class="info-item d-flex flex-column align-items-start">
                                        <div class="mb-2"><label>파일 선택</label></div>
                                        <div id="insert-file-dropzone" class="dropzone"></div>
                                        <jsp:include page="../file/file.jsp" />
                                    </div>
                                </div>
                            </section>
                        </div>
                    </section>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" id="output-save" class="save-button">&nbsp;&nbsp;저장하기&nbsp;&nbsp;</button>&nbsp;&nbsp;
                    <button type="button" class="cancel-button" data-bs-dismiss="modal">&nbsp;&nbsp;닫기&nbsp;&nbsp;</button>
                </div>
            </div>
        </div>
    </div>
</form>

<script>
    let selectedNode = null;
    let myDropzone;
    let mask = new ax5.ui.mask();

    $(function () {
        Dropzone.autoDiscover = false;
        const $selectElement = $('#task-select');
        const $selectBox = $('.select-box');

        let selectedOptions = [];
        $selectElement.on('change', function() {
            const value = $selectElement.val();
            if (value && !selectedOptions.includes(value)) {
                selectedOptions.push(value);
                createLabel(value);
            }
            $selectElement.val('');
        });

        function createLabel(value) {
            const optionText = $selectElement.find('option[value="' + value + '"]').text();
            const $label = $('<div>', {
                class: 'label-item',
                text: optionText
            });

            const $removeBtn = $('<button>', {
                class: 'remove-btn',
                html: '&times;'
            });

            $removeBtn.on('click', function() {
                $label.remove();
                selectedOptions = selectedOptions.filter(function(val) {
                    return val !== value;
                });
            });

            $label.append($removeBtn);
            $selectBox.append($label);
        }

        function getFullPath(node) {
            let path = node.text;
            let parentNode = window.jsTreeInstance.jstree(true).get_parent(node);

            while(parentNode && parentNode !== '#') {
                let parentNodeData = window.jsTreeInstance.jstree(true).get_node(parentNode);
                if(parentNodeData && parentNodeData.text) {
                    path = parentNodeData.text + ' > ' + path;
                    parentNode = window.jsTreeInstance.jstree(true).get_parent(parentNodeData);
                } else {
                    break;
                }
            }
            return path;
        }

        // 노드 선택 이벤트 핸들러
        $('.jstree-folder').on("select_node.jstree", function (e, data) {
            selectedNode = data.node;
            let fullPath = getFullPath(selectedNode);
            $('.file-loc').text(fullPath);
        });

        $('#insertModal').on('show.bs.modal', function() {
            isSaved = false;
        });

        $('#insertModal .save-button').on('click', function() {
            isSaved = true;
        });

        $('#insertModal').on('hidden.bs.modal', function() {
            if (!isSaved) {
                selectedOptions = [];
                $selectBox.empty();

                $('.txt-area').val('');
                $('.note-area').val('');
            }
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        const dropzonePreviewNode = document.querySelector('.file-zone .dropzone-preview-list');
        dropzonePreviewNode.id = '';
        const previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        if (!myDropzone) {
            myDropzone = initDropzone('#insert-file-dropzone', '.file-zone', previewTemplate);
        }

        $('#output-save').on('click', function(e) {
            e.preventDefault();
            insertData(myDropzone, $('#outputForm')[0]);
        });
    });

    function initDropzone(selector, preDiv, previewTemplate) {
        const url = "http://localhost:8085";
        return new Dropzone(selector, {
            url: url + "/api/risk",
            method: "post",
            contentType: false,
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: preDiv + ' .dropzone-preview',
            acceptedFiles:
                '.jpg,.jpeg,.png,.gif,.bmp,.tiff,.svg,.webp,.' +
                'doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.txt,.rtf,.csv,.md,' +
                '.zip,.rar,.7z,.tar,.gz,.bz2,' +
                '.xml,.json,.psd,.ai,' +
                '.mp4,.mov,.avi,.mp3,.wav',
            dictInvalidFileType: '허용되지 않는 파일 형식입니다.',
            maxFilesize: 20,
            dictFileTooBig: '파일 크기가 너무 큽니다. 최대 파일 크기는 {{maxFilesize}}MB입니다.',
        });
    }

    function insertData(dropzone, $form) {
        if (!selectedNode) {
            toast.push({
                theme: 'warning',
                msg: '파일 위치를 선택해주세요.'
            });
            return;
        }

        let files = dropzone.files;
        let formData = new FormData($form);

        if (files.length > 0) {
            for (let i = 0; i < files.length; i++) {
                let file = files[i];
                if (file.size > 20 * 1024 * 1024) {
                    toast.push({
                        theme: 'warning',
                        msg: '최대 파일 크기는 20MB입니다.'
                    });
                    return;
                } else if (file.name && file.name.length > 50) {
                    toast.push({
                        theme: 'warning',
                        msg: '최대 파일 이름 길이는 50자입니다.'
                    });
                    return;
                }
                formData.append('files', file);
            }
        }

        // 파일 검증 통과 후에 노드 추가
        let parentNodeId = selectedNode.id;
        let newNode = {
            id: findMaxId(window.treeData[0]) + 1,
            text: $form.title.value,
            type: 'n'
        };

        $('.jstree-folder').jstree('create_node', parentNodeId, newNode, "last", function(new_node) {
            $('.jstree-folder').jstree('deselect_all', true);
            $('.jstree-folder').jstree('select_node', new_node);
            $('.jstree-folder').jstree('open_node', parentNodeId);
        });

        let treeData = $('.jstree-folder').jstree(true).get_json('#', { flat: false });
        let updatedTreeData = transformTreeData(treeData);

        formData.append('res', new Blob([JSON.stringify(updatedTreeData)], { type: "application/json" }));
        formData.append('res', JSON.stringify(updatedTreeData));

        mask.open();
        $.ajax({
            url: '/projects/outputs/api/save',
            type: 'post',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                if (files.length > 0) {
                    files.forEach(file => {
                        file.status = Dropzone.SUCCESS;
                        dropzone.emit("complete", file);
                    });
                }
                $('#insertModal').modal('hide');
                $('.txt-area').val('');
                $('.note-area').val('');

                mask.close();
                window.location.href = '/projects/outputs?no=' + response + '&toastMsg=산출물 파일이 성공적으로 저장되었습니다.';
            },
            error: function(response) {
                console.error(response);
            }
        });
    }

    function transformTreeData(treeNodes, parentId = null) {
        refineTreeIds(treeNodes);
        return treeNodes.map(node => {
            const nodeId = Number(node.id.split('.').pop());
            const children = node.children ? transformTreeData(node.children, nodeId) : [];

            return {
                id: nodeId,
                text: node.text,
                type: node.type,
                parentId: parentId,
                children: children
            };
        });
    }

    function refineTreeIds(treeData) {
        function traverseNodes(node) {
            if (Array.isArray(node)) {
                node.forEach(childNode => traverseNodes(childNode));
            } else {
                // 마지막 '.'의 위치를 찾고 그 뒤의 숫자를 새로운 ID로 사용
                let lastIndex = node.id.lastIndexOf('.');
                if (lastIndex !== -1) {
                    node.id = node.id.substring(lastIndex + 1);
                }
                // 자식 노드가 있다면 재귀적으로 처리
                if (node.children && node.children.length > 0) {
                    traverseNodes(node.children);
                }
            }
        }
        traverseNodes(treeData);
        return treeData;
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
</script>
