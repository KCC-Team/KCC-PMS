<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" />

<style>
    .file-style .select-box-list {
        margin-left: 20px;
        width: 250px;
        padding: 10px;
        overflow-y: auto;
    }

    .file-style .dropzone {
        border-radius: 5px;
        width: 100%;
        min-height: 30px;
        padding: 10px;
    }

    .file-style .dropzone-preview .dz-preview {
        width: 150px;
        margin: 5px;
    }

    .file-style .dropzone-preview .dz-preview .dz-filename {
        font-size: 12px;
    }

    .file-style .dropzone-preview .dz-preview .dz-size,
    .file-style .dropzone-preview .dz-preview .dz-error-message {
        font-size: 10px;
    }

    .file-style .dropzone-preview li.dz-preview {
        width: 100%;
        margin: 5px 0;
    }

    .file-style .dropzone-preview .dz-preview {
        width: 100%;
    }

    .file-style .dropzone-preview .dz-preview .dz-image {
        flex: 0 0 auto;
        margin-right: 15px;
    }

    .file-style .dz-image img {
        width: 40px !important;
        height: 40px;
    }

    .file-style .dropzone-preview .dz-preview .dz-details {
        flex: 1 1 auto;
        overflow: hidden;
    }

    .file-style .dropzone-preview .dz-preview .dz-remove {
        flex: 0 0 auto;
        margin-left: 15px;
    }

    .file-style .dropzone-preview .dz-preview .dz-filename,
    .file-style .dropzone-preview .dz-preview .dz-size {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .file-style .file-section {
        height: 230px;
        border: 1px solid #C5C5C5;
        padding: 10px;
        overflow-y: auto;
    }
</style>

<div class="modal fade" id="fileInsertModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: #070606; font-weight: bold">산출물 파일 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
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
                                    <div><label class="text-nowrap">연결 작업 선택&nbsp;&nbsp;&nbsp;</label></div>
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
                    <div class="file-style w-100">
                        <div class="file-section mt-3">
                            <div class="info-item d-flex flex-column align-items-start">
                                <div class="mb-2"><label>파일 선택</label></div>
                                    <div id="output-file-dropzone" class="dropzone"></div>
                                    <jsp:include page="../file/file.jsp" />
                            </div>
                        </div>
                    </div>
                    <div class="select-box-list">
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
    document.addEventListener('DOMContentLoaded', function() {
        if (Dropzone.instances.length > 0) {
            Dropzone.instances.forEach(function(dz) {
                dz.destroy();
            });
        }

        const dropzonePreviewNode = document.querySelector('.file-style .dropzone-preview-list');
        dropzonePreviewNode.id = '';
        const previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        const dropzone = initDropzone('#output-file-dropzone', '.file-style', previewTemplate);

        $('.save-button').on('click', function(e) {
            e.preventDefault();
            dropzone.processQueue();
        });

        // 미구현 경로 임으로 임시로 처리
        dropzone.processQueue = function() {
            this.emit('queuecomplete');
        };
    });
</script>
