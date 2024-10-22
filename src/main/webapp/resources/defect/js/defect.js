document.addEventListener('DOMContentLoaded', function() {
    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    // 첫 번째 Dropzone
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

    const dropzone1 = initDropzone('#df-insert-file-dropzone_1', '.file-zone_1', previewTemplate1, "/projects/defects/files");
    // 업로드 성공 시 이미지 링크 설정
    dropzone1.on("success", function(file, response) {
        // 서버에서 이미지 URL을 반환한다고 가정
        const imageUrl = response.imageUrl;
        const previewElement = file.previewElement;
        const imageLink = previewElement.querySelector(".dz-image-link");
        imageLink.href = imageUrl;
    });

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

    const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate2, "/projects/defects/files");
    // 업로드 성공 시 이미지 링크 설정
    dropzone2.on("success", function(file, response) {
        // 서버에서 이미지 URL을 반환한다고 가정
        const imageUrl = response.imageUrl;
        const previewElement = file.previewElement;
        const imageLink = previewElement.querySelector(".dz-image-link");
        imageLink.href = imageUrl;
    });

    $('#save-df').on('click', function(e) {
        uploadFiles(dropzone1); // Process upload for Dropzone 1
        uploadFiles(dropzone2);
    });
});

function uploadFiles(dropzone) {
    let files = dropzone.files;
    let formData = new FormData();

    files.forEach(file => {
        formData.append('files', file); // 'files'는 서버측에서 List<MultipartFile>로 받기 위한 필드 이름입니다.
    });
    console.log(dropzone.files);
    console.log(dropzone.getFilesWithStatus(Dropzone.ADDED));

    $.ajax({
        url: dropzone.options.url,
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            console.log('Files uploaded successfully');
            files.forEach(file => {
                file.status = Dropzone.SUCCESS;
                dropzone.emit("complete", file);
            });
        },
        error: function(response) {
            console.error('Failed to upload files');
            files.forEach(file => {
                file.status = Dropzone.ERROR;
                dropzone.emit("error", file);
            });
        }
    });
}

$(function () {
    $(".defect-date").datepicker({
        dateFormat: "yyyy-mm-dd"
    });
});