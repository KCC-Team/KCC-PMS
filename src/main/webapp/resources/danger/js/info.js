let deletedFiles = []
let discoverFiles;
let workFiles;
let dropzone1;
let dropzone2;
let riskNo;
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

    dropzone1 = initDropzone('#risk-insert-file-dropzone_1', '.file-zone_1', previewTemplate, "/projects/risks/risk");
    dropzone2 = initDropzone('#risk-insert-file-dropzone_2', '.file-zone_2', previewTemplate, "/projects/risks/risk");


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

    console.log(recordDate);
    console.log(recordContent);

    $.ajax({
        url: '/projects/risks/history',
        type: 'POST',
        data: {
            recordContent : recordContent,
            recordDate: recordDate,
            riskNo: riskNo
        },
        success: function (response){
            // 모달 창 닫기
            $('#exampleModal').modal('hide');

            // 폼 초기화
            $('#historyForm')[0].reset();

            getHisotries();
        }
    })
})

function getHisotries(){
    $.ajax({
        url: '/projects/risks/history?riskNo=' + riskNo,
        type: 'GET',
        success: function (his){
            console.log("his=" ,his);
            // history-section 요소를 비웁니다
            $('.history-section').empty();

            // 이력 제목 추가
            $('.history-section').append('<div class="history-title">이력</div>');

            // 조회된 이력을 반복하여 각 항목을 history-item으로 추가
            his.forEach(item => {
                const formattedDate = item.recordDate.substring(0, 10); // '년-월-일' 형식으로 변환
                const historyItemHtml = `
                    <div class="history-item">
                        <div class="history-header">
                            <div class="history-name">${item.memberName}</div>
                            <div class="history-date">${formattedDate}</div>
                        </div>
                        <div class="history-content">
                            ${item.recordContent}
                        </div>
                    </div>
                `;
                // 생성한 HTML을 history-section에 추가
                $('.history-section').append(historyItemHtml);
            });
        }
    })
}