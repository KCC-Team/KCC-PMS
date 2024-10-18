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