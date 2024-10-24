let deletedFiles = [];

document.addEventListener('DOMContentLoaded', function() {
    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    const previewTemplate = `
        <div class="dz-preview dz-file-preview">
            <a target="_blank" class="dz-image-link">
                <img data-dz-thumbnail style="width: 65px; height: 65px"/>
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
    const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate);

    discoverFiles.forEach(function(file) {
        let mockFile = {
            id: file.fileNumber,
            name: file.fileName,
            size: file.fileSize,
            url: file.filePath,
            isExisting: true // 기존 파일임을 나타냅니다.
        };

        dropzone1.emit("addedfile", mockFile);
        dropzone1.emit("thumbnail", mockFile, file.filePath);
        dropzone1.emit("complete", mockFile);

        let previewElement = mockFile.previewElement;
        if (previewElement) {
            previewElement.classList.add("existing-file");

            let removeButton = previewElement.querySelector("[data-dz-remove]");
            let imageLink = previewElement.querySelector(".dz-image-link");
            if (imageLink) {
                imageLink.href = file.filePath;
            }
        }
        dropzone1.files.push(mockFile);
    });

    dropzone1.on("removedfile", function(file) {
        if (file.isExisting) {
            deletedFiles.push(file.id);
        }
    });

    $('#save-df').on('click', function(e) {
        e.preventDefault();
        let $form = $('#defectForm')[0];

        if (getDefectNumberFromPath() && !isNaN(getDefectNumberFromPath())) {
            updateData(dropzone1, dropzone2, $form, getDefectNumberFromPath());
        } else {
            insertData(dropzone1, dropzone2, $form);
        }
    });

    $('.del-btn').on('click', function(e) {
        e.preventDefault();
        let defectNumber = getDefectNumberFromPath();
        if (defectNumber == null) {
            window.close();
        }

        $.ajax({
            url: "/projects/defects/" + defectNumber,
            type: 'delete',
            success: function (response) {
                window.close();
            },
            error: function (response) {
                alert('삭제 실패');
            }
        });
    });

    $('#can-df').on('click', function(e) {
        e.preventDefault();
        window.close();
    });
});

$(function () {
    $(".defect-date").datepicker({
        dateFormat: "yy-mm-dd"
    });

    let defectNumber = getDefectNumberFromPath();
    if (defectNumber && !isNaN(defectNumber)) {
        $('.del-btn').show();
    }

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);

        let systemNo = $('#systemNo').val();
        if (systemNo) {
            // 메뉴 데이터에서 해당 systemNo를 가진 메뉴 항목을 찾음
            let selectedPath = findMenuPathBySystemNo(menuData, systemNo);
            if (selectedPath) {
                // 선택된 시스템 경로를 표시
                $('#system-select span:first-child').text(selectedPath);
            }
        }
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();
    });

});

function getDefectNumberFromPath() {
    const path = window.location.pathname;
    const segments = path.split('/');
    return segments[segments.length - 1];
}

function insertData(dropzone_dis, dropzone_work, $form) {
    let dis_files = dropzone_dis.files;
    let work_files = dropzone_work.files;

    let formData = new FormData($form);
    if (dis_files.length > 0) {
        dis_files.forEach(file => {
            formData.append('disFiles', file);
        });
    }
    if (work_files.length > 0) {
        work_files.forEach(file => {
            formData.append('workFiles', file);
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
            window.location.href = response;
        },
        error: function(response) {
            console.error(response);
        }
    });
}

function updateData(dropzone_dis, dropzone_work, $form, defectNumber) {
    let dis_files = dropzone_dis.files;
    let work_files = dropzone_work.files;

    let formData = new FormData($form);
    if (dis_files.length > 0) {
        dis_files.forEach(file => {
            if (!file.isExisting) {
                formData.append('disFiles', file);
            }
        });
    }
    if (work_files.length > 0) {
        work_files.forEach(file => {
            if (!file.isExisting) {
                formData.append('workFiles', file);
            }
        });
    }
    if (deletedFiles.length > 0) {
        deletedFiles.forEach(file => {
            formData.append('deleteFiles', file);
        });
    }

    $.ajax({
        url: "/projects/defects/" + defectNumber,
        type: 'put',
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
            deletedFiles = [];
            window.location.href = response;
        },
        error: function(response) {
            console.error(response);
        }
    });
}

function fetchMenuData() {
    return $.ajax({
        url: '/systems',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("systems: " + response);
            return response;
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}

function createMenu(menuData) {
    createMenuHTML(menuData, $('#system-menu'), "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        const listItem = $('<li class="menu-item"></li>');
        const itemLabel = $('<span></span>').text(menuItem.systemTitle);
        listItem.append(itemLabel);

        const subMenu = $('<ul class="system-submenu"></ul>');
        const currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);

            // 하위 메뉴 토글 기능 추가
            itemLabel.click(function(event) {
                event.stopPropagation();
                subMenu.slideToggle();
            });
        } else {
            // 하위 메뉴가 없는 경우 클릭 시 시스템 선택
            itemLabel.click(function(event) {
                event.stopPropagation();
                $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
                $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
                $('#system-menu').slideUp();  // 메뉴 숨기기
            });
        }

        parentElement.append(listItem);
    });
}

