document.addEventListener('DOMContentLoaded', function() {
    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    const dropzonePreviewNode = document.querySelector('.file-zone_1 .dropzone-preview-list');
    const dropzonePreviewNode2 = document.querySelector('.file-zone_2 .dropzone-preview-list');
    dropzonePreviewNode.id = '';
    const previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
    dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
    dropzonePreviewNode2.parentNode.removeChild(dropzonePreviewNode2);

    const dropzone = initDropzone('#df-insert-file-dropzone_1', '.file-zone_1', previewTemplate);
    const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate);

    $('.save-button').on('click', function(e) {
        e.preventDefault();
        dropzone.processQueue();
        dropzone2.processQueue();
    });

    // 미구현 경로 임으로 임시로 처리
    dropzone.processQueue = function() {
        this.emit('queuecomplete');
    };
    dropzone2.processQueue = function() {
        this.emit('queuecomplete');
    };
});