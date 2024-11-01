let deletedFiles = []
let discoverFiles;
let workFiles;
let dropzone1;
let dropzone2;
let riskNo;
let historyDropzone;
document.addEventListener('DOMContentLoaded', function() {
    console.log('auth code !!!! !' + authCode);
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
                <div class="dz-filename"><span data-dz-name style="width: 100px"></span></div>
                <div class="dz-size" data-dz-size></div>
                <span class="button-icon" data-dz-remove><i class="fas fa-trash-alt"></i></span>
            </div>
            <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
            <div class="dz-error-message"><span data-dz-errormessage></span></div>
        </div>
    `;

    dropzone1 = initDropzone('#risk-insert-file-dropzone_1', '.file-zone_1', previewTemplate, "/projects/risks/risk");
    dropzone2 = initDropzone('#risk-insert-file-dropzone_2', '.file-zone_2', previewTemplate, "/projects/risks/risk");
    historyDropzone = initDropzone("#history-insert-file-dropzone", '.file-zone_3', previewTemplate, "/projects/risks/risk");

    dropzone1.on("removedfile", function(file) {
        if (file.isExisting) {
            deletedFiles.push(file.id);
        }
    });

    dropzone2.on("removedfile", function(file) {
        if (file.isExisting) {
            deletedFiles.push(file.id);
        }
    });

    historyDropzone.on("removedfile", function(file) {
        if (file.isExisting && file.id) {
            if (!deletedFiles.includes(file.id)) {
                deletedFiles.push(file.id);
            }
        }
    });

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

    const urlParams = new URLSearchParams(window.location.search);
    const type = urlParams.get('type');
    riskNo = urlParams.get('no');
    console.log("riskNo = " + riskNo);
    if (type === 'register') {
        console.log("registerMember = ", registerMember);
        console.log(typeof registerMember);
        $('#memberNo').val(registerMember.memNo); // memberNo 설정
        $('#memberName').val(registerMember.memberName); // memberName 설정
    }

    fetchOptions();

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
        if(riskNo){
            getRiskInfo(riskNo);
        }
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");

    $('#saveRisk').on('click', function(e) {
        e.preventDefault();
        let $form = $('#riskForm')[0];

        let requestUrl = "/projects/risks/risk";
        let requestMethod = "POST";

        if (riskNo) {  // featNo가 존재하면 업데이트로 가정
            requestMethod = "PUT";
        }
        console.log("form Data", $form);
        insertData(dropzone1, dropzone2, $form, requestUrl, requestMethod);
    });

    $('.del-btn').on('click', function(e) {
        e.preventDefault();
        let riskNumber = riskNo;
        if (riskNumber == null) {
            window.close();
        }

        $.ajax({
            url: "/projects/risks/" + riskNumber,
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

    $('.dz-image-file').on('click', function(e) {
        if (e.target.src.includes('file-icon.png')) {
            $.ajax({
                url: '/fileDownload?=filePath=' + e.target.src,
                method: 'GET',
            });
        }
    });

    getHisotries();
});



function insertData(dropzone_dis, dropzone_work, $form, requestUrl, requestMethod) {
    let formData;
    let dis_files;
    let work_files
    if(requestMethod === 'POST'){
        dis_files = dropzone_dis.files;
        work_files = dropzone_work.files;

        formData = new FormData($form);
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
    } else if(requestMethod === 'PUT'){
        dis_files = dropzone_dis.files;
        work_files = dropzone_work.files;

        formData = new FormData($form);
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
    }

    $.ajax({
        url: requestUrl,
        type: requestMethod,
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
            console.log("redirect url");
            console.log(response);
            deletedFiles = [];
            window.location.href = response;
        },
        error: function(response) {
            console.error(response);
        }
    });
}



function getRiskInfo(riskNo){
    $.ajax({
        url: '/projects/risks/risk/' + riskNo,
        type: 'GET',
        success: function (response){
            console.log("riskInfo = ", response);
            discoverFiles = JSON.parse(response.discoverFilesJson || '[]');
            workFiles = JSON.parse(response.workFilesJson || '[]');
            push();
            updateForm(response);
        },
        error: function (xhr, status, error) {
            alert("조회 중 문제가 발생했습니다. 다시 시도해주세요.");
            console.log(xhr, status, error);
        }
    })
}

function push(){

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


    discoverFiles.forEach(function(file) {
        let mockFile = {
            id: file.fileNumber,
            name: file.fileName,
            size: file.fileSize,
            url: file.filePath,
            isExisting: true
        };

        dropzone1.emit("addedfile", mockFile);
        console.log(file);
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


}


function updateForm(data){
    $('#risk_ttl').val(data.riskTitle);
    $('#riskNumber').val(data.riskNumber);
    $('#riskTitle').val(data.riskTitle);
    $('#PMS005').val(data.classCode);
    $('#riskId').val(data.riskId);
    $('#PMS006').val(data.priorCode);
    $('#riskContent').val(data.riskContent);
    $('#riskPlan').val(data.riskPlan);
    $('#dueDate').val(data.dueDate);
    $('#completeDate').val(data.completeDate);
    $('#PMS004').val(data.statusCode);
    $('#memberNo').val(data.memberNo);
    $('#memberName').val(data.memberName);
    $('#systemNo').val(data.systemNo);
    setSystemPath(data.systemNo);
}

function setSystemPath(systemNo) {
    var selectedItem = $('[data-system-no="' + systemNo + '"]');
    if (selectedItem.length) {
        var path = selectedItem.data('parent-path') || selectedItem.text(); // 'data-parent-path'를 사용하되, 없다면 text() 사용
        $('#system-select span:first-child').text(path);
    }
}

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
    const parentElement = $('#system-menu');

    // "전체" 메뉴 항목 추가
    const allMenuItem = $('<li class="menu-item"></li>').text("전체");
    allMenuItem.click(function(event) {
        event.stopPropagation();
        let projectTitle = document.querySelector('.common-project-title').textContent.trim();
        $('#system-select span:first-child').text('전체');
        $('#systemNo').val("");  // 전체 시스템을 의미하도록 systemNo 필드 비우기
        $('.mymenu').slideUp();  // 메뉴 숨기기
    });
    parentElement.append(allMenuItem);  // "전체" 메뉴 항목을 최상단에 추가

    // 기존 메뉴 생성
    createMenuHTML(menuData, parentElement, "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        var currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;
        var listItem = $('<li>', {
            'class': 'menu-item',
            'data-system-no': menuItem.systemNo,
            'data-parent-path': currentPath,
            'text': menuItem.systemTitle
        });

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            var subMenu = $('<ul>', {'class': 'system-submenu'});
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


$('#addHistoryBtn').click(function (e) {
    e.preventDefault();
    const recordDate = $('#record_dt').val();
    const recordContent = $('#record_cont').val();
    const historyNo = $('#historyNo').val();

    console.log(recordDate);
    console.log(recordContent);

    if (!recordDate) {
        alert("조치일자는 필수 입력 항목입니다.");
        $('#record_dt').focus();
        return;
    }

    let formData = new FormData();
    formData.append('recordDate', recordDate);
    formData.append('recordContent', recordContent);
    formData.append('riskNo', riskNo);

    // `historyNo`가 존재하면 수정으로 처리
    if (historyNo) {
        formData.append('historyNo', historyNo);
    }

    // Dropzone의 파일 첨부 처리: 새로 추가된 파일만 전송
    historyDropzone.files.forEach(file => {
        if (!file.isExisting) {  // 새로 추가된 파일만 전송
            formData.append('historyFiles', file);
        }
    });

    if (deletedFiles.length > 0) {
        deletedFiles.forEach(file => {
            formData.append('deleteFiles', file);
        });
    }

    // FormData의 내용을 확인 (디버깅용)
    for (let pair of formData.entries()) {
        console.log(pair[0] + ', ' + pair[1]);
    }

    $.ajax({
        url: '/projects/risks/history',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function (response) {
            historyDropzone.removeAllFiles(true);
            $('#historyModal').modal('hide');
            $('#historyForm')[0].reset();
            $('#historyNo').val('');
            deletedFiles = []
            getHisotries();
        },
        error: function (xhr, status, error) {
            console.error("Error:", error);
            alert("요청 처리 중 문제가 발생했습니다. 다시 시도해주세요.");
        }
    });
});



function getHisotries(){
    $.ajax({
        url: '/projects/risks/history?riskNo=' + riskNo,
        type: 'GET',
        success: function(his) {
            console.log("his=", his);
            $('.history-section').empty();
            $('.history-section').append('<div class="history-title">조치이력</div>');

            his.forEach(item => {
                const formattedDate = item.recordDate.substring(0, 10);
                const filesHtml = generateFileLinks(item.historyFilesJson, item.historyNo);

                const historyItemHtml = `
                    <div class="history-item">
                        <div class="history-header">
                            <div class="history-name">${item.memberName}</div>
                            <div class="history-date-wrapper">
                                <button class="edit-history-btn" data-history-no="${item.historyNo}">수정</button>
                                <button class="delete-history-btn" data-history-no="${item.historyNo}">삭제</button>
                                <div class="history-date">${formattedDate}</div>
                            </div>
                        </div>
                        <div class="history-content">
                            ${item.recordContent}
                        </div>
                        <div class="history-files">
                            ${filesHtml}
                        </div>
                    </div>
                `;
                $('.history-section').append(historyItemHtml);
            });

            // 삭제 버튼 클릭 이벤트 리스너 추가
            $('.delete-history-btn').on('click', function() {
                const historyNo = $(this).data('history-no');
                deleteHistory(historyNo);
            });
        }
    });
}


// 파일 링크를 생성하는 함수
function generateFileLinks(filesJson) {
    const files = JSON.parse(filesJson || '[]');
    return files.map(file => {
        const fileExtension = file.filePath.split('.').pop().toLowerCase();
        const isImage = ['jpg', 'jpeg', 'png', 'gif', 'jfif'].includes(fileExtension);

        if (isImage) {
            return `<a href="${file.filePath}" target="_blank"><img src="${file.filePath}" class="thumbnail"></a>`;
        } else {
            return `<a href="${file.filePath}" target="_blank"><i class="fas fa-file"></i> ${file.fileName}</a>`;
        }
    }).join('');
}


$(document).on('click', '.edit-history-btn', function(e) {
    e.preventDefault();
    const historyNo = $(this).data('history-no');
    console.log("historyNo = " + historyNo);
    openEditHistoryModal(historyNo);
});

function openEditHistoryModal(historyNo) {
    $.ajax({
        url: '/projects/risks/history/' + historyNo,
        type: 'GET',
        success: function(response) {
            console.log(response);
            $('#record_dt').val(formatDate(response.recordDate));
            $('#record_cont').val(response.recordContent);

            // 중복 방지를 위해 기존 파일을 모두 제거하고 초기화
            historyDropzone.removeAllFiles(true);
            historyDropzone.files = [];  // files 배열을 초기화하여 중복 방지

            const historyFiles = JSON.parse(response.historyFilesJson || '[]');

            historyFiles.forEach(file => {
                let mockFile = {
                    id: file.fileNumber,
                    name: file.fileName,
                    size: file.fileSize,
                    url: file.filePath,
                    isExisting: true
                };
                historyDropzone.emit("addedfile", mockFile);
                historyDropzone.emit("thumbnail", mockFile, file.filePath);
                historyDropzone.emit("complete", mockFile);
                historyDropzone.files.push(mockFile); // Dropzone의 files 배열에 추가
            });

            // 수정 시 사용할 historyNo 설정
            $('#historyNo').val(historyNo);

            $('#historyModal').modal('show'); // 모달 열기
        }
    });
}


function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// 모달이 닫힐 때 dropzone 초기화
$('#historyModal').on('hidden.bs.modal', function () {
    historyDropzone.removeAllFiles(true);  // 기존 파일 제거
    historyDropzone.files = [];  // Dropzone 파일 배열 초기화
    $('#historyForm')[0].reset();  // 폼 초기화
    $('#historyNo').val('');  // historyNo 초기화
});