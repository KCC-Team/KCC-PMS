$(document).ready(function() {
    console.log("prjNo = " + prjNo);
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

    fetchOptions();

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");

});



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



// 오늘 날짜를 "YYYY-MM-DD" 형식으로 반환하는 함수
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더함
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
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


function fetchOptions() {
    $.ajax({
        url: '/api/risk/options',
        method: 'GET',
        success: function(data) {
            console.log(data)
            data.forEach(function(item) {
                console.log(item);
                const selectId = '#' + item.common_cd_no;
                const $selectElement = $(selectId);

                if ($selectElement.length) {
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

        $selectElement.append($option);
    });
}


function createMenu(menuData) {
    createMenuHTML(menuData, $('#system-menu'), "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        const listItem = $('<li class="menu-item"></li>').text(menuItem.systemTitle);
        const subMenu = $('<ul class="system-submenu"></ul>');

        const currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
            $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
            $('.mymenu').slideUp();  // 메뉴 숨기기
        });

        parentElement.append(listItem);
    });
}