<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" />

<meta charset="UTF-8">
<style>
    .modal-content-in {
        background-color: #F6F6F6;
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
        height: 300px;
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
                            <div class="info-item d-flex flex-column align-items-start">
                                <div class="d-flex justify-content-start">
                                    <div><label class="text-nowrap">제목&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                    <span><textarea class="txt-area" style="width: 270px"></textarea></span>
                                </div>
                                <div>
                                    <br>
                                    <div><label>파일 위치&nbsp;&nbsp;&nbsp;<label class="es-star">*</label></label><span class="file-loc"></span></div>
                                    <div class="jstree-div" style="width: 325px!important; height: 400px">
                                        <jsp:include page="../jstree-folder.jsp" />
                                    </div>
                                </div>
                            </div>
                        </section>
                        <section class="file-zone w-100 p-2">
                            <div class="file-section" style="height: 484px">
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
                <button type="button" class="save-button" data-bs-dismiss="modal">&nbsp;&nbsp;저장하기&nbsp;&nbsp;</button>&nbsp;&nbsp;
                <button type="button" class="cancel-button" data-bs-dismiss="modal">&nbsp;&nbsp;닫기&nbsp;&nbsp;</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(function () {
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
                    path = parentNodeData.text + ' / ' + path;
                    parentNode = window.jsTreeInstance.jstree(true).get_parent(parentNodeData);
                } else {
                    break;
                }
            }
            return path;
        }

        // 노드 선택 이벤트 핸들러
        $('.jstree-folder').on("select_node.jstree", function (e, data) {
            let selectedNode = data.node;
            let fullPath = getFullPath(selectedNode);
            $('.file-loc').text(fullPath);
        });

        $('#insertModal').on('show.bs.modal', function() {
            isSaved = false;
        });

        $('#insertModal .save-button').on('click', function() {
            isSaved = true;
        });

        // 이후 다른 필드 초기화 처리 로직도 추가
        $('#insertModal').on('hidden.bs.modal', function() {
            if (!isSaved) {
                selectedOptions = [];
                $selectBox.empty();
            }
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        if (Dropzone.instances.length > 0) {
            Dropzone.instances.forEach(function(dz) {
                dz.destroy();
            });
        }

        const dropzonePreviewNode = document.querySelector('.file-zone .dropzone-preview-list');
        dropzonePreviewNode.id = '';
        const previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        const dropzone = initDropzone('#insert-file-dropzone', '.file-zone', previewTemplate);

        $('.save-button').on('click', function(e) {
            e.preventDefault();
            dropzone.processQueue();
        });

        // 미구현 경로 임으로 임시로 처리
        dropzone.processQueue = function() {
            this.emit('queuecomplete');
        };
    });

    Dropzone.autoDiscover = false;
    function initDropzone(selector, preDiv, previewTemplate) {
        const url = "http://localhost:8085";
        return new Dropzone(selector, {
            url: url + "/api/risk",
            method: "post",
            contentType: false,
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: preDiv + ' .dropzone-preview',
        });
    }
</script>
