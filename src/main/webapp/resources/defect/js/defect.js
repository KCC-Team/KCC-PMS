document.addEventListener('DOMContentLoaded', function() {
    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    // 첫 번째 Dropzone
    const previewTemplate = `
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
  
    const dropzone1 = initDropzone('#df-insert-file-dropzone_1', '.file-zone_1', previewTemplate, "/projects/defects/defect");
    // 업로드 성공 시 이미지 링크 설정
    dropzone1.on("success", function(file, response) {
        // 서버에서 이미지 URL을 반환한다고 가정
        const imageUrl = response.imageUrl;
        const previewElement = file.previewElement;
        const imageLink = previewElement.querySelector(".dz-image-link");
        imageLink.href = imageUrl;
    });

    const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate);
    // 업로드 성공 시 이미지 링크 설정
    dropzone2.on("success", function(file, response) {
        // 서버에서 이미지 URL을 반환한다고 가정
        const imageUrl = response.imageUrl;
        const previewElement = file.previewElement;
        const imageLink = previewElement.querySelector(".dz-image-link");
        imageLink.href = imageUrl;
    });

    $('#save-df').on('click', function(e) {
        e.preventDefault();
        let $form = $('#defectForm')[0];

        uploadFiles(dropzone1, dropzone2, $form);
    });
});

function uploadFiles(dropzone_dis, dropzone_work, $form) {
    let dis_files = dropzone_dis.files;
    let work_files = dropzone_work.files;

    let formData = new FormData($form);
    if (dis_files.length > 0) {
        dis_files.forEach(file => {
            formData.append('dis_files', file);
        });
    }
    if (work_files.length > 0) {
        work_files.forEach(file => {
            formData.append('work_files', file);
        });
    }

    $.ajax({
        url: dropzone_dis.options.url,
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            if (dis_files.length > 0) {
                dis_files.forEach(file => {
                    file.status = Dropzone.SUCCESS;
                    dropzone_dis.emit("complete", file);
                });
            }

            if (work_files.length > 0) {
                work_files.forEach(file => {
                    file.status = Dropzone.SUCCESS;
                    dropzone_work.emit("complete", file);
                });
            }
        },
        error: function(response) {
            console.error(response);
        }
    });
}

$(function () {
    $(".defect-date").datepicker({
        dateFormat: "yy-mm-dd"
    });
});
