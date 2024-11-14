let deleteFiles = [];

document.addEventListener('DOMContentLoaded', function() {
    if (Dropzone.instances.length > 0) {
        Dropzone.instances.forEach(function(dz) {
            dz.destroy();
        });
    }

    const previewTemplate = `
        <div class="dz-preview dz-file-preview">
            <a target="_blank" class="dz-image-link">
                <img
                    data-dz-thumbnail
                    style="width: 85px; height: 85px"
                    src="#"
                    class="dz-image-file"
                    onerror="this.onerror=null; this.src='../../../../resources/output/images/file-icon.png';"
                />
            </a>
            <div class="dz-details">
                <div class="dz-filename"><span data-dz-name style="width: 80px"></span></div>
                <div class="dz-size" data-dz-size></div>
                <span class="button-icon" data-dz-remove><i class="fas fa-trash-alt"></i></span>
            </div>
            <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
            <div class="dz-error-message"><span data-dz-errormessage></span></div>
        </div>
    `;
  
    const dropzone1 = initDropzone('#df-insert-file-dropzone_1', '.file-zone_1', previewTemplate, "/projects/defects/defect");
    const dropzone2 = initDropzone('#df-insert-file-dropzone_2', '.file-zone_2', previewTemplate, "/projects/defects/defect");

    discoverFiles.forEach(function(file) {
        let mockFile = {
            id: file.fileNumber,
            name: file.fileName,
            size: file.fileSize,
            url: file.filePath,
            isExisting: true
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

    workFiles.forEach(function(file) {
        let mockFile = {
            id: file.fileNumber,
            name: file.fileName,
            size: file.fileSize,
            url: file.filePath,
            isExisting: true
        };

        dropzone2.emit("addedfile", mockFile);
        dropzone2.emit("thumbnail", mockFile, file.filePath);
        dropzone2.emit("complete", mockFile);

        let previewElement = mockFile.previewElement;
        if (previewElement) {
            previewElement.classList.add("existing-file");

            let removeButton = previewElement.querySelector("[data-dz-remove]");
            let imageLink = previewElement.querySelector(".dz-image-link");
            if (imageLink) {
                imageLink.href = file.filePath;
            }
        }
        dropzone2.files.push(mockFile);
    });

    dropzone1.on("removedfile", function(file) {
        if (file.isExisting) {
            deleteFiles.push(file.id);
        }
    });

    dropzone2.on("removedfile", function(file) {
        if (file.isExisting) {
            deleteFiles.push(file.id);
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
        if (window.opener && !window.opener.closed) {
            let event = new Event('defectSaved');
            window.opener.dispatchEvent(event);
        }
    });

    $('.del-btn').on('click', function(e) {
        e.preventDefault();
        let defectNumber = getDefectNumberFromPath();
        if (defectNumber == null) {
            window.close();
            return;
        }

        isPassedAlert().then(function (isPassed) {
            if (isPassed) {
                $.ajax({
                    url: '/projects/defects/' + defectNumber,
                    method: 'delete',
                    success: function (response) {
                        if (window.opener && !window.opener.closed) {
                            let event = new Event('defectDeleted');
                            window.opener.dispatchEvent(event);
                        }
                        window.close();
                    },
                    error: function (xhr, status, error) {
                        console.error('삭제에 실패했습니다.', error);
                    }
                });
            }
        });
    });

    $('#can-df').on('click', function(e) {
        e.preventDefault();
        window.close();
    });

    let toast = new ax5.ui.toast({
        containerPosition: "top-right",
        onStateChanged: function(){
            console.log(this);
        }
    });

    const urlParams = new URLSearchParams(window.location.search);
    const toastMsg = urlParams.get('toastMsg');

    if (toastMsg === "defectDeleted") {
        toast.push({
            theme: 'success',
            msg: "결함 내역 저장이 완료되었습니다."
        });
    }


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
            setSystemPath(systemNo);
        }
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();
    });

    let val = $('#systemNo').val();

    setSystemPath(val);
    fetchOptions();

    $('.dz-image-file').on('click', function(e) {
        if (e.target.src.includes('file-icon.png')) {
            $.ajax({
                url: '/fileDownload?=filePath=' + e.target.src,
                method: 'GET',
            });
        }
    });

    $('#PMS007').val("PMS00701");
    $('.defect-date').val(new Date().toISOString().slice(0, 10));
});

function getDefectNumberFromPath() {
    const path = window.location.pathname;
    const segments = path.split('/');
    return segments[segments.length - 1];
}

function fetchOptions() {
    $.ajax({
        url: '/projects/defects/options',
        method: 'GET',
        success: function(data) {
            data.forEach(function(item) {
                const selectId = '#' + item.common_cd_no;
                const $selectElement = $(selectId);

                if ($selectElement.length) {
                    console.log(item);
                    setOptions($selectElement, item.codes);

                }
            });
        },
        error: function(xhr, status, error) {
            console.error('옵션 데이터를 가져오는데 실패했습니다.', error);
        }
    });
}

function setOptions($selectElement, options) {
    options.forEach(function(option) {

        // 각 option 태그 생성
        const $option = $('<option>', {
            value: option.cd_dtl_no,
            text: option.cd_dtl_nm
        });

        if (option.cd_dtl_no === 'PMS00801' && testDetailNo != null) {
            $option.attr('selected', 'selected');
        } else if (option.cd_dtl_no === typeSelect) {
            $option.attr('selected', 'selected');
        } else if (option.cd_dtl_no === prioritySelect) {
            $option.attr('selected', 'selected');
        } else if (option.cd_dtl_no === statusSelect) {
            $option.attr('selected', 'selected');
        }


        $selectElement.append($option);

    });
}

function insertData(dropzone_dis, dropzone_work, $form) {
    let dis_files = dropzone_dis.files;
    let work_files = dropzone_work.files;

    let formData = new FormData($form);
    for (let file of dis_files) {
        formData.append('disFiles', file);
    }

    for (let file of work_files) {
        formData.append('workFiles', file);
    }

    $.ajax({
        url: dropzone_dis.options.url,
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            // 성공 로직
            window.location.href = response + "?toastMsg=defectSaved";
            
		    if (window.opener && !window.opener.closed) {
		        window.opener.submitTestData();
		    }
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

    for (let file of dis_files) {
        if (!file.isExisting) {
            formData.append('disFiles', file);
        }
    }

    for (let file of work_files) {
        if (!file.isExisting) {
            formData.append('workFiles', file);
        }
    }

    if (deleteFiles && deleteFiles.length > 0) {
        deleteFiles.forEach(file => {
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
            deleteFiles = [];
            window.location.href = response + "?toastMsg=defectSaved";
            
            if (window.opener && !window.opener.closed) {
		        window.opener.submitTestData();
		    }
        },
        error: function(response) {
            console.error(response);
        }
    });
}

window.addEventListener('message', function (event) {
    if (event.data.type === 'defect1') {
        $('#fd_mem_no').val(event.data.member[0].id);
        $('#fd_mem_nm').val(event.data.member[0].memberName);
    } else if (event.data.type === 'defect2') {
        $('#work_mem_no').val(event.data.member[0].id);
        $('#work_mem_nm').val(event.data.member[0].memberName);
    }
});

function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
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
        let currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;
        let listItem = $('<li>', {
            'class': 'menu-item',
            'data-system-no': menuItem.systemNo,
            'data-parent-path': currentPath,
            'text': menuItem.systemTitle
        });

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            let subMenu = $('<ul>', {'class': 'system-submenu'});
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath); // 선택된 경로 표시
            $('#systemNo').val(menuItem.systemNo); // 시스템 번호를 숨겨진 필드에 저장
            $('.mymenu').slideUp(); // 메뉴 숨기기
        });

        parentElement.append(listItem);
    });
}

function setSystemPath(systemNo) {
    let selectedItem = $('[data-system-no="' + systemNo + '"]');
    console.log(selectedItem);
    if (selectedItem.length) {
        let path = selectedItem.data('parent-path') || selectedItem.text();
        $('#system-select span:first-child').text(path);
    }
}

function confirmationDialog() {
    return Swal.fire({
        title: "확인",
        text: "이 작업을 진행하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "확인",
        cancelButtonText: "취소",
    });
}

function isPassedAlert() {
    return new Promise(function(resolve, reject) {
        confirmationDialog().then((result) => {
            if (result.isConfirmed) {
                Swal.fire("완료!", "작업이 성공적으로 완료되었습니다.", "success");
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });
}
