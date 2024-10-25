<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .custom-radio {
        transform: scale(1.1);
        margin-right: 6px;
    }

    .custom-label {
        font-size: 15px;
    }

    .modal-dialog-centered .jstree-folder-in {
        height: 300px;
        border: 1px solid #C5C5C5;
        padding: 10px;
        overflow-y: auto;
    }
</style>

<div class="modal fade" id="folderModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: #070606; font-weight: bold">새 폴더 생성</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <section class="info-section d-flex flex-column">
                    <input type="text" class="form-control mb-1" id="search" placeholder="폴더를 검색하세요." style="width: 270px;">
                    <div>
                        <div class="jstree-folder-in">
                        </div>
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
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="save-button" data-bs-dismiss="modal">&nbsp;&nbsp;저장하기&nbsp;&nbsp;</button>&nbsp;&nbsp;
                <button type="button" class="cancel-button" data-bs-dismiss="modal">&nbsp;&nbsp;닫기&nbsp;&nbsp;</button>
            </div>
        </div>
    </div>
</div>
