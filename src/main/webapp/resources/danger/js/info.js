$(document).ready(function() {
    // Dropzone 자동 초기화 방지
    Dropzone.autoDiscover = false;

    // Dropzone 강제 초기화
    if (!$("#df-insert-file-dropzone_1").hasClass("dz-clickable")) {
        var discoveryDropzone = new Dropzone("#df-insert-file-dropzone_1", {
            url: "/api/risk", // 실제 서버 URL 설정
            autoProcessQueue: false,  // 자동으로 업로드되지 않도록 설정
            uploadMultiple: true,     // 여러 파일을 동시에 업로드 가능
            parallelUploads: 100,     // 병렬로 업로드할 수 있는 파일 개수
            maxFiles: 100,            // 최대 업로드 파일 개수
            addRemoveLinks: true,     // 파일 제거 링크 추가
            dictDefaultMessage: "파일을 여기에 드래그하거나 클릭하여 추가하세요.", // 기본 메시지
            previewsContainer: "#dropzone1_preview", // 미리보기 컨테이너 설정
            clickable: true,          // 클릭하여 파일 추가 가능
            init: function() {
                var dropzoneInstance = this;

                // "업로드" 버튼 클릭 시 Dropzone의 큐 처리
                $(".save-btn").click(function(e) {
                    e.preventDefault(); // 기본 폼 동작 방지
                    dropzoneInstance.processQueue(); // Dropzone 큐 처리 시작
                });

                // 파일 업로드 시 처리할 내용 추가
                this.on("addedfile", function(file) {
                    console.log("파일이 추가되었습니다:", file);
                });

                this.on("sendingmultiple", function(files, xhr, formData) {
                    // 여기에 폼 데이터를 추가해서 함께 전송
                    formData.append("risk_ttl", $("#risk_ttl").val());
                    formData.append("risk_id", $("#risk_id").val());
                    // 필요한 다른 폼 필드 추가...
                });

                // 업로드 성공 이벤트
                this.on("successmultiple", function(files, response) {
                    console.log("파일 업로드 성공:", response);
                    alert("이미지 업로드 완료 (" + files.length + ")");
                });

                // 업로드 실패 이벤트
                this.on("errormultiple", function(files, response) {
                    console.log("파일 업로드 실패:", response);
                    alert("파일 업로드 중 오류가 발생했습니다.");
                });
            }
        });
    }
    
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
            data.forEach(function(item) {
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