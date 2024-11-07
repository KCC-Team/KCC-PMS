<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" />

<style>
    .modal-dialog-ouput .modal-content {
        height: 600px;
        background-color: #F6F6F6;
    }

    .modal-dialog-ouput .modal-dialog {
        max-width: 800px !important;
        margin: auto;
    }

    .modal-dialog-ouput .modal-body .info-section {
        margin-bottom: 20px;
    }

    .file-zone-3 .select-box-list {
        margin-left: 20px;
        width: 250px;
        padding: 10px;
        overflow-y: auto;
    }

    .file-zone-3 #output-file-dropzone_file {
        border-radius: 5px;
        width: 100%;
        min-height: 30px !important;
        padding: 10px;
    }

    .modal-body-output .file-zone-3 #output-file-dropzone_file {
        border-radius: 5px;
        width: 100%;
        min-height: 50px !important;
        max-height: 50px !important;
    }

    #output-file-dropzone_file > .dz-message {
        margin: 5px !important;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .file-zone-3 .dropzone-preview .dz-preview {
        width: 150px;
        margin: 5px;
    }

    .file-zone-3 .dropzone-preview .dz-preview .dz-filename {
        font-size: 12px;
    }

    .file-zone-3 .dropzone-preview .dz-preview .dz-size,
    .file-zone-3 .dropzone-preview .dz-preview .dz-error-message {
        font-size: 10px;
    }

    .file-zone-3 .dropzone-preview li.dz-preview {
        width: 100%;
        margin: 5px 0;
    }

    .file-zone-3 .dropzone-preview .dz-preview {
        width: 100%;
    }

    .file-zone-3 .dropzone-preview .dz-preview .dz-image {
        flex: 0 0 auto;
        margin-right: 15px;
    }

    .file-zone-3 .dz-image img {
        width: 40px !important;
        height: 40px;
    }

    .file-zone-3 .dropzone-preview .dz-preview .dz-details {
        flex: 1 1 auto;
        overflow: hidden;
    }

    .file-zone-3 .dropzone-preview .dz-preview .dz-remove {
        flex: 0 0 auto;
        margin-left: 15px;
    }

    .file-zone-3 .dropzone-preview .dz-preview .dz-filename,
    .file-zone-3 .dropzone-preview .dz-preview .dz-size {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .modal-body-output .file-zone-3 .file-section {
        height: 350px;
        border: 1px solid #C5C5C5;
        padding: 10px;
        overflow-y: auto;
    }
</style>

<div class="modal fade" id="fileInsertModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
    <form id="fileInsertForm">
        <div class="modal-dialog modal-dialog-centered modal-dialog-ouput">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" style="color: #070606; font-weight: bold">산출물 파일 등록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body modal-body-output">
                    <section class="info-section">
                        <div class="d-flex justify-content-between">
                            <div class="info-item">
                                <div class="info-item d-flex align-items-start ms-3">
                                    <div class="d-flex justify-content-start">
                                        <div><label class="text-nowrap">제목&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                        <span><input type="text" class="file_name txt-area" value="example" disabled /></span>
                                    </div>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-item d-flex flex-column align-items-start">
                                    <div class="d-flex justify-content-start">
                                        <div><label class="text-nowrap">연결 작업&nbsp;&nbsp;&nbsp;</label></div>
                                        <!-- 이후 jstl로 반복문 돌려서 작업 목록 가져오기 -->
                                        <div>
                                            <div>현행 업무분석</div>
                                            <div>업무 프로세스 분석</div>
                                        </div>
                                        <!-- -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <hr>
                    <section>
                        <div class="file-zone-3 w-100">
                            <div class="file-section mt-3">
                                <div class="info-item d-flex flex-column align-items-start">
                                    <div class="mb-2"><label>파일 선택</label></div>
                                        <div id="output-file-dropzone_file" class="dropzone"></div>
                                        <jsp:include page="../file/file.jsp" />
                                </div>
                            </div>
                        </div>
                        <div class="select-box-list">
                        </div>
                    </section>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" id="output-file-save" class="save-button" data-bs-dismiss="modal">&nbsp;저장하기&nbsp;</button>&nbsp;&nbsp;
                    <button type="button" class="cancel-button" data-bs-dismiss="modal">&nbsp;&nbsp;닫기&nbsp;&nbsp;</button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    let fileDropzone;

    document.addEventListener('DOMContentLoaded', function() {
        const dropzonePreviewNode = document.querySelector('.file-zone-3 .dropzone-preview-list');
        dropzonePreviewNode.id = '';
        const previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        if (!fileDropzone) {
            fileDropzone = initDropzone('#output-file-dropzone_file', '.file-zone-3', previewTemplate);
        }

        $('#output-file-save').on('click', function(e) {
            e.preventDefault();
            insertFiles(fileDropzone, $('#fileInsertForm')[0]);
        });
    });

    function insertFiles(dropzone, $form) {
        console.log($form);
        let files = dropzone.files;

        let formData = new FormData();
        formData.append('outputNo', $('#outputNo').val());

        if (files.length > 0) {
            files.forEach(file => {
                formData.append('files', file);
            });
        }


        $.ajax({
            url: '/projects/outputs/api/fileinsert',
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
                    $('.file_name').val('');
                    $('.txt-area').val('');
                    window.location.href = '/projects/outputs?no=' + $('#outputNo').val();
                } else {
                    window.location.href = response;
                }
            },
            error: function(response) {
                console.error(response);
            }
        });
    }
</script>
