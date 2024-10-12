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