$(document).ready(function (){
    window.addEventListener("message", function(event) {
        if (event.data.type === 'featureMember') {
            let receivedMember = event.data.member;
            console.log("받은 멤버 :", receivedMember);

            document.getElementById("mem_no").value = receivedMember[0].id;
            document.getElementById("mem_nm").value = receivedMember[0].memberName;
            document.getElementById("tm_no").value = receivedMember[0].teamNo;
        }
    }, false);

    console.log("prjNo = " + prjNo)

    fetchOptions();


    $("#pre_st_dt, #pre_end_dt, #st_dt, #end_dt").datepicker({
        dateFormat: "yy-mm-dd"  // 원하는 형식으로 날짜 표시
    });


    $(".btn-save-feature").on("click", function (e) {
        e.preventDefault();
        const formData = $("#feat_form").serializeArray();
        const formDataObject = {};

        formData.forEach(function(item) {
            formDataObject[item.name] = item.value;
        });

        // 'featClassCode'가 선택되지 않았다면 기본값 'PMS01005'를 설정
        if (!formDataObject.classCode || formDataObject.classCode === "") {
            formDataObject.classCode = "PMS01005";
        }

        let requestUrl = "/projects/features";
        let requestMethod = "POST";

        if (formDataObject.featNo) {  // featNo가 존재하면 업데이트로 가정
            requestMethod = "PUT";
        }

        console.log("Form Data:", formDataObject);


        $.ajax({
            url: requestUrl,
            type: requestMethod,
            data: formDataObject,
            success: function (response) {
                console.log(response);
                alert("저장이 완료되었습니다.");
                if(requestMethod === 'POST'){
                    window.opener.postMessage({
                        status: 'register',
                        message: 'Feature saved successfully',
                        systemNo: formDataObject.systemNo,
                        featClassCd: formDataObject.classCode
                    }, '*');
                } else {
                    window.opener.postMessage({
                        status: 'update',
                        message: 'Feature update successfully',
                        systemNo: formDataObject.systemNo,
                        featClassCd: formDataObject.classCode,
                        memberNo: formDataObject.memberNo
                    }, '*');
                }

                window.close();
            },
            error: function (xhr, status, error) {
                alert("저장 중 문제가 발생했습니다. 다시 시도해주세요.");
                console.log(xhr, status, error);
            }
        });
    });

    fetchMenuData()
        .then(function(menuData) {
            createMenu(menuData);
            if (featureNo) {
                console.log("featureNo: " + featureNo);
                return getFeatureInfo(featureNo); // Promise 반환
            }
        })
        .then(function() {
            initializeProgressField(); // getFeatureInfo가 완료된 후 실행
        })
        .catch(function(error) {
            console.error("Error:", error); // 오류 처리
        });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");


    initializeProgressField();

    $('#PMS009').on('change', function() {
        updateProgressField($(this).val());
    });


})

function initializeProgressField() {
    var initialValue = $('#PMS009').val();
    updateProgressField(initialValue);
}

function updateProgressField(selectedValue) {
    var progressValue;
    var todayDate = new Date().toISOString().slice(0, 10); // yyyy-mm-dd 형식의 오늘 날짜

    switch (selectedValue) {
        case 'PMS00903':
            progressValue = 70;
            $('#prg').prop('disabled', true);
            break;
        case 'PMS00904':
            progressValue = 80;
            $('#prg').prop('disabled', true);
            break;
        case 'PMS00905':
            progressValue = 90;
            $('#prg').prop('disabled', true);
            break;
        case 'PMS00906':
            progressValue = 100;
            $('#prg').prop('disabled', true);
            $('#end_dt').val(todayDate);
            break;
        case 'PMS00901':
        case 'PMS00902':
            progressValue = 0;
            $('#prg').prop('disabled', false); // prg 선택 가능
            $('#end_dt').val('');
            break;
        default:
            progressValue = 0;
            $('#prg').prop('disabled', false); // prg 선택 가능
            $('#end_dt').val('');
            break;
    }

    $('#prg').val(progressValue); // 진척도 값을 설정합니다
}

function fetchOptions() {
    $.ajax({
        url: '/projects/features/options',
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


function createMenu(menuData) {
    createMenuHTML(menuData, $('#system-menu'), "");
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
            $('#system-select span:first-child').text(currentPath); // 선택된 경로 표시
            $('#systemNo').val(menuItem.systemNo); // 시스템 번호를 숨겨진 필드에 저장
            $('.mymenu').slideUp(); // 메뉴 숨기기
        });

        parentElement.append(listItem);
    });
}

function getFeatureInfo(featNo) {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: '/projects/features/details?featNo=' + featNo,
            type: 'GET',
            success: function(response) {
                console.log("featureInfo: ", response);
                $('#featNo').val(response.featNo);
                $('#feat_title').val(response.featTitle);
                $('#feat_id').val(response.featId);
                $('#pre_st_dt').val(response.preStartDateStr);
                $('#pre_end_dt').val(response.preEndDateStr);
                $('#st_dt').val(response.startDateStr);
                $('#end_dt').val(response.endDateStr);

                $('#PMS009').val(response.statusCode);
                $('#PMS006').val(response.priorCode);
                $('#PMS011').val(response.diffCode);
                $('#PMS010').val(response.classCode);
                $('#prg').val(response.progress);

                $('#feat_cont').val(response.featDescription);
                $('#mem_no').val(response.memberNo);
                $('#mem_nm').val(response.memberName);
                $('#tm_no').val(response.teamNo);

                // 시스템 번호도 존재한다면 해당 시스템 번호 선택
                $('#systemNo').val(response.systemNo);
                setSystemPath(response.systemNo);


                response.testNo.forEach(function(test) {
                    var link = document.createElement('a');
                    link.href = "https://www.kccpms.co.kr/projects/tests/" + test.testNo;
                    link.textContent = test.testId;
                    link.target = "_blank"; // 새 창에서 열기

                    // 링크 간에 공백 추가
                    document.getElementById('testIdList').appendChild(link);
                    document.getElementById('testIdList').appendChild(document.createTextNode(" "));
                });


                resolve(); // 성공 시 Promise를 resolve
            },
            error: function(xhr, status, error) {
                console.error("Failed to fetch feature info:", xhr, status, error);
                reject(error); // 오류 발생 시 Promise를 reject
            }
        });
    });
}

function setSystemPath(systemNo) {
    var selectedItem = $('[data-system-no="' + systemNo + '"]');
    if (selectedItem.length) {
        var path = selectedItem.data('parent-path') || selectedItem.text(); // 'data-parent-path'를 사용하되, 없다면 text() 사용
        $('#system-select span:first-child').text(path);
    }
}