// 오늘 날짜를 "YYYY-MM-DD" 형식으로 반환하는 함수
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더함
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

$(document).ready(function() {
    const dateInput = $('#record_dt');
    if (!dateInput.val()) {
        dateInput.val(getTodayDate());
    }

    const due_input = $('#due_dt');
    if (!due_input.val()) {
        due_input.val(getTodayDate());
    }

    const compl_input = $('#compl_date');
    if (!compl_input.val()) {
        compl_input.val(getTodayDate());
    }

});


document.addEventListener('DOMContentLoaded', function() {
    var defectActionContent = '${defectActionContent}';
    var hasDefectActionContent = defectActionContent && defectActionContent.trim() !== '';

    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    // 첫 번째 Dropzone
    const dropzonePreviewNode = document.querySelector('.file-zone_1 .dropzone-preview-list');
    if (dropzonePreviewNode) {
        const previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
        const dropzone = initDropzone('#df-insert-file-dropzone_1', '.file-zone_1', previewTemplate);

        // 미구현 경로 임으로 임시로 처리
        dropzone.processQueue = function() {
            this.emit('queuecomplete');
        };

        $('.save-button').on('click', function(e) {
            e.preventDefault();
            dropzone.processQueue();
        });
    }

    if (hasDefectActionContent) {
        const dropzonePreviewNode2 = document.querySelector('.file-zone_2 .dropzone-preview-list');
        if (dropzonePreviewNode2) {
            const previewTemplate2 = dropzonePreviewNode2.parentNode.innerHTML;
            dropzonePreviewNode2.parentNode.removeChild(dropzonePreviewNode2);
            const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate2);

            dropzone2.processQueue = function() {
                this.emit('queuecomplete');
            };

            $('.save-button').on('click', function(e) {
                e.preventDefault();
                dropzone2.processQueue();
            });
        }
    }
});