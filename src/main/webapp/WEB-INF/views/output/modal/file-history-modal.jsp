<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<meta charset="UTF-8">
<style>
    #historyModal span {
        font-size: 13px;
        font-weight: lighter;
        color: #575757;
    }

    .modal-dialog-his .modal-content {
        display: flex;
        flex-direction: column;
        background-color: #F6F6F6;
    }

    #historyModal td {
        color: #696969 !important;
    }

    .modal-dialog-his {
        max-width: 1000px;
        margin: auto;
    }

    .modal-dialog-his .modal-body .info-section {
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 20px;
    }

    .modal-dialog-his .modal-body .info-item {
        display: flex;
        align-items: center;
        flex: 1;
        min-width: 450px;
    }

    .modal-dialog-his .modal-body .info-item label {
        flex: 0 0 80px;
        color: #070606;
        font-weight: bolder;
        font-size: 15px;
        margin-right: 10px;
    }

    .modal-dialog-his .modal-body .info-item span {
        flex: 1;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .modal-dialog-his .card-body:hover {
        border: 1px solid #a2a2a2;
    }

    .modal-dialog-his .versionHistory {
        height: 500px;
        border: 1px solid #C5C5C5;
        overflow-y: auto;
    }

    .modal-dialog-his .versionHistory {
        max-height: 500px;
        overflow-y: auto;
    }

    .modal-dialog-his .version-history-table {
        width: 100%;
        border-collapse: collapse;
    }

    .modal-dialog-his .version-history-table thead {
        position: sticky;
        top: 0;
        background-color: #EDF0F5;
        z-index: 1;
    }

    .version-history-table th, .version-history-table td {
        text-align: center;
        padding: 8px;
        border-bottom: 1px solid #9a9999;
    }

    .version-history-table tbody tr:hover {
        background-color: #EDF0F5;
    }

    .version-history-table thead th {
        background-color: #EDF0F5;
        border-bottom: 2px solid #aaa;
    }

    .info-section span {
        font-size: 15px;
    }
</style>
<div class="modal modal-his fade" id="historyModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-his modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="fileModalLabel" style="color: #070606; font-weight: bold">산출물 삭제 기록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <section class="version-history-section mt-3">
                    <div class="versionHistory">
                    </div>
                </section>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="cancel-button" data-bs-dismiss="modal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;닫기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
            </div>
        </div>
    </div>
</div>
