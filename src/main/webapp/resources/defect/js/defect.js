document.addEventListener('DOMContentLoaded', function() {
    let defectActionContent = '${defectActionContent}';
    let hasDefectActionContent = defectActionContent && defectActionContent.trim() !== '';

    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    // 첫 번째 Dropzone
    const dropzonePreviewContainer1 = document.querySelector('.file-zone_1 .dropzone-preview');
    if (dropzonePreviewContainer1) {
        // 미리보기 템플릿 정의
        const previewTemplate1 = `
            <div class="dz-preview dz-file-preview">
                <a href="" target="_blank" class="dz-image-link">
                    <img data-dz-thumbnail style="width: 85px;"/>
                </a>
                <div class="dz-details">
                    <div class="dz-filename"><span data-dz-name style="width: 100px"></span></div>
                    <div class="dz-size" data-dz-size></div>
                    <span class="button-icon" data-dz-remove><i class="fas fa-trash-alt"></i></span>
                </div>
                <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
                <div class="dz-error-message"><span data-dz-errormessage></span></div>
            </div>
        `;

        const dropzone1 = initDropzone('#df-insert-file-dropzone_1', '.file-zone_1', previewTemplate1);

        // 업로드 성공 시 이미지 링크 설정
        dropzone1.on("success", function(file, response) {
            // 서버에서 이미지 URL을 반환한다고 가정
            const imageUrl = response.imageUrl;
            const previewElement = file.previewElement;
            const imageLink = previewElement.querySelector(".dz-image-link");
            imageLink.href = imageUrl;
        });

        // 미구현 경로 임으로 임시로 처리
        dropzone1.processQueue = function() {
            this.emit('queuecomplete');
        };

        $('.save-button').on('click', function(e) {
            e.preventDefault();
            dropzone1.processQueue();
        });
    }

    if (hasDefectActionContent) {
        const dropzonePreviewContainer2 = document.querySelector('.file-zone_2 .dropzone-preview');
        if (dropzonePreviewContainer2) {
            // 미리보기 템플릿 정의
            const previewTemplate2 = `
                <div class="dz-preview dz-file-preview">
                    <a href="" target="_blank" class="dz-image-link">
                        <img data-dz-thumbnail />
                    </a>
                    <div class="dz-details">
                        <div class="dz-filename"><span data-dz-name></span></div>
                        <div class="dz-size" data-dz-size></div>
                    </div>
                    <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
                    <div class="dz-error-message"><span data-dz-errormessage></span></div>
                </div>
            `;

            const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate2);

            // 업로드 성공 시 이미지 링크 설정
            dropzone2.on("success", function(file, response) {
                // 서버에서 이미지 URL을 반환한다고 가정
                const imageUrl = response.imageUrl;
                const previewElement = file.previewElement;
                const imageLink = previewElement.querySelector(".dz-image-link");
                imageLink.href = imageUrl;
            });

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
