
$(function() {
    $(".test-date").datepicker({
        dateFormat: "yy-mm-dd"
    });

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);

        let systemNo = $('#systemNo').val();
        if (systemNo) {
            setSystemPath(systemNo);
        }
    });
    fetchOptions();

    let testCaseIdx = 0;
    let testCaseCnt = 1;
    let testCnt = 1;
    let workTaskCnt = 1;

    function generateUnitTestcase(index, testCase) {
        // 조회 모드인지 여부에 따라 disabled 속성 설정
        let disabledAttr = isViewMode === 'true' ? 'disabled' : '';

        // 테스트 케이스 ID 설정
        let testCaseId = testCase && testCase.testDtlId ? testCase.testDtlId : $('#test_id').val() + "_" + (index + 1);

        // 각 필드의 값 설정 (조회 모드일 경우 데이터 사용, 생성 모드일 경우 빈 문자열)
        let preCondition = testCase && testCase.preCondition ? testCase.preCondition : '';
        let testCaseCont = testCase && testCase.testCaseCont ? testCase.testCaseCont : '';
        let preoceedCont = testCase && testCase.preoceedCont ? testCase.preoceedCont : '';
        let testData = testCase && testCase.testData ? testCase.testData : '';
        let estimatedResult = testCase && testCase.estimatedResult ? testCase.estimatedResult : '';
        let note = testCase && testCase.note ? testCase.note : '';

        return `<section>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>순번</div>
                        <span>${index + 1}</span>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트케이스 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <input type="text" name="testCaseList[${index}].testDtlId" value="${testCaseId}" readonly>
                    </div>
                </div>
                <br>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>사전조건</label></div>
                        <textarea class="test-data" name="testCaseList[${index}].preCondition" ${disabledAttr} >${preCondition}</textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트케이스 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <textarea class="test-data" name="testCaseList[${index}].testCaseCont" ${disabledAttr} >${testCaseCont}</textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>수행절차</div>
                        <textarea class="test-data" name="testCaseList[${index}].preoceedCont" ${disabledAttr} >${preoceedCont}</textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트 데이터</label></div>
                        <textarea class="test-data" name="testCaseList[${index}].testData" ${disabledAttr} >${testData}</textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>예상결과</div>
                        <textarea class="test-data" name="testCaseList[${index}].estimatedResult" ${disabledAttr} >${estimatedResult}</textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>비고</label></div>
                        <textarea class="test-data" name="testCaseList[${index}].note" ${disabledAttr} >${note}</textarea>
                    </div>
                </div>
            </section>
            <br><hr>`;
    }

    function generateIntegrationTest() {
        let testCaseId = $('#test_id').val() + "_" + testCaseCnt;
        return `<section class="integration-test">
                    <div class="d-flex justify-content-start">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="me-4">
                            <div class="d-flex justify-content-start"><label>순번</div>
                            <span>` + testCaseIdx + `</span>
                        </div>&nbsp;&nbsp;&nbsp;
                        <div class="ms-4">
                            <div class="d-flex justify-content-start"><label>테스트케이스 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <span id="test_`+ testCaseCnt + `">` + testCaseId + `</span>
                        </div>
                    </div>
                    <br>
                    ` + generateWorkTask(testCaseId) + `
               </section>
               <br><hr>`;
    }

    function generateWorkTask(testCaseId) {
        return `<section class="work-task_${testCaseId}_${workTaskCnt}">
                        <div class="d-flex justify-content-start">
                            <div class="me-4">
                                <div class="d-flex justify-content-start"><label>테스트 업무처리 내용&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                            </div>&nbsp;&nbsp;&nbsp;
                        </div>
                        <div class="test-area">
                        ` + generateTestDetails(testCaseId) + `
                            <button class="add-test-detail custom-button">테스트 추가</button>
                        </div>
                        <br>
                        <div class="info-item d-flex flex-column align-items-start">
                            <div><label class="text-nowrap">관련 프로그램&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <div class="d-flex justify-content-start">
                                <select class="form-select" aria-label="Multiple select example" id="task-select-list" style="height: 40px !important; width: 350px;">
                                    <option value="" selected disabled>작업 선택하기</option>
                                    <option value="1">현행 업무분석</option>
                                    <option value="2">업무 프로세스 분석</option>
                                </select>
                                <div class="select-box-list">
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="d-flex justify-content-start">
                            <div class="me-4">
                                <div class="d-flex justify-content-start"><label>사전조건&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                            </div>&nbsp;&nbsp;&nbsp;
                            <div class="ms-4">
                                <div class="d-flex justify-content-start"><label>비고</label></div>
                                <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                            </div>
                        </div>
                        <div class="d-flex justify-content-start">
                            <div class="me-4">
                                <div class="d-flex justify-content-start"><label>테스트 데이터&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></div>
                                <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                            </div>&nbsp;&nbsp;&nbsp;
                            <div class="ms-4">
                                <div class="d-flex justify-content-start"><label>예상 결과&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                            </div>
                        </div>
                        <hr>
                    </section>
                    <div class="d-flex justify-content-center">
                        <button class="add-new-work-task-btn btn btn-secondary">테스트 업무 추가</button>
                    </div>
                    `;
    }

    function generateTestDetails(testCaseId) {
        return `
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>테스트 ID</div>
                        <span>` + (testCaseId + "_" + workTaskCnt + "_" + testCnt++) + `</span>
                    </div>&nbsp;&nbsp;&nbsp;
                </div>
                <br>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>테스트 내용&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                </div><br>`;
    }

    let $textarea = $('#test-txt');
    let $wordCountContainer = $('.word-count');
    let maxLength = 500;

    $textarea.on('input', function() {
        let currentText = $textarea.val();
        let currentLength = currentText.length;

        $wordCountContainer.text(currentLength + ' / ' + maxLength);

        if (currentLength > maxLength) {
            $textarea.val(currentText.substr(0, maxLength));
            $wordCountContainer.text(maxLength + ' / ' + maxLength);

            $wordCountContainer.addClass('over-limit');
        } else {
            $wordCountContainer.removeClass('over-limit');
        }
    });

    $('#testType').change(function() {
        updateButtonVisibility();

        let selectedOption = $(this).val();
        let html;
        if (selectedOption === 'PMS01201') {
            $('.tc-area').show();
            html = `
                <label class="ms-4 fw-bold fs-2 text-black">
                       단위 테스트 등록</label>
               <hr>
               <div class="me-4">
                    <div class="d-flex justify-content-start"><label>기능 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                    <div class="d-flex justify-content-start">
                        <select id="feat" name="testCaseList[` + testCaseIdx + `].featNo" required ` + $('#disabled').val() + ` >
                            <option value="" selected disabled>선택하세요.</option>
                            <option value="1">RSTR110</option>
                            <option value="2">RSTR111</option>
                            <option value="3">RSTR123</option>
                            <option value="4">RSTR221</option>
                            <option value="5">RSTR222</option>
                        </select>
                    </div>
                </div><br>
            `;
            html += generateUnitTestcase(testCaseIdx, {});
        } else if (selectedOption === 'PMS01202') {
            $('.tc-area').show();
            html = `
                <label class="ms-4 fw-bold fs-2 text-black">
                       통합 테스트 등록</label>
               <hr>
            `;
            html += generateIntegrationTest();
        }

        $('#dynamic-content').html(html);
        $(document).on('click', '.tc-btn', function() {
            if (selectedOption === 'PMS01201') {
                ++testCaseIdx;
                $('#dynamic-content').append(generateUnitTestcase(testCaseIdx, {}));
            }
            else if (selectedOption === 'PMS01202') {
                ++testCaseCnt;
                $('#dynamic-content').append(generateIntegrationTest());
            }
            testCnt = 1;
            workTaskCnt = 1;
        });

        $(document).on('click', '.add-new-work-task-btn', function() {
            let testCaseId = $(`#test_${testCaseCnt}`).text();
            testCnt = 1;
            let work_selector = `.work-task_${testCaseId}_${workTaskCnt}`;
            workTaskCnt++;
            let newWorkTask = generateWorkTask(testCaseId);
            $(`.add-new-work-task-btn`).remove();
            $(work_selector).after(newWorkTask);
        });
    });

    $('#dynamic-content').on('click', '.add-test-detail', function() {
        let testCaseId = $(`#test_` + testCaseCnt).text();
        if (testCaseId) {
            let newDetail = generateTestDetails(testCaseId);
            $(this).before(newDetail);
            $('.test-area').scrollTop($('.test-area').height() * $('.test-area').height());
        }
    });

    $('.add-new-integration-test').on('click', function() {
        $('#dynamic-content').append(generateIntegrationTest());
    });

    function loadFeatureIdList() {
        $.ajax({
            url: '/projects/api/functionIds',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                populateFunctionIdOptions(data);
            },
            error: function(xhr, status, error) {
                console.error('기능 ID 리스트를 가져오는 중 오류 발생:', error);
            }
        });
    }

    function populateFunctionIdOptions(data) {
        const $select = $('#feat');
        $select.empty();
        $select.append('<option value="선택하세요." selected disabled></option>');

        $.each(data, function(index, item) {
            $select.append('<option value="' + item.id + '">' + item.name + '</option>');
        });
    }

    $('#test-form').submit(function(e) {
       e.preventDefault();

        let formData = new FormData(this);
        let jsonObject = {};

        for (let [name, value] of formData.entries()) {
            let keys = name.match(/[^\[\]]+/g); // 'testCaseList[0].testCaseId' => ['testCaseList', '0', 'testCaseId']
            assignValue(jsonObject, keys, value);
        }

        $.ajax({
            url: '/projects/tests/register',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(jsonObject),
            success: function(response) {
                location.href = '/projects/tests';
            },
            error: function(error) {
                alert('테스트 등록 중 오류가 발생했습니다.');
            }
        });
    });

    $('.cancel').click(function(e) {
        e.preventDefault();
        location.href = '/projects/tests';
    });

    let path = window.location.pathname;
    const regex = /tests\/(\d+)$/;
    let match = path.match(regex);
    if (match){
        let testNo = match[1];
        $.ajax({
            url: `/projects/tests/api/${testNo}`,
            type: 'GET',
            success: function (data) {
                console.log(data);
                if (data.testCaseList && data.testCaseList.length > 0) {
                    data.testCaseList.forEach(function (testCase, index) {
                        let testCaseHtml = generateUnitTestcase(index, testCase);
                        $('#dynamic-content').append(testCaseHtml);
                        $(`input[name="testCaseList[${index}].testDtlId"]`).val(testCase.testDtlId);
                        $(`textarea[name="testCaseList[${index}].preCondition"]`).val(testCase.preCondition);
                    });
                }

                $('input, select, textarea').attr('disabled', true);
                $('.tc-btn').hide();
                $('.cancel').hide();
                $('button').attr('disabled', true);
            },
            error: function (error) {
                console.error('테스트 데이터를 가져오는 중 오류 발생:', error);
                alert('데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }

    $('.delete-btn').click(function() {
        let testNo = $('#testNo').val();
        $.ajax({
            url: `/projects/tests/${testNo}`,
            type: 'DELETE',
            success: function(response) {
                location.href = '/projects/tests';
            },
            error: function(error) {
                alert('테스트 삭제 중 오류가 발생했습니다.');
            }
        });
    });
});

function assignValue(obj, keys, value) {
    if (keys[0] === 'testCaseList') {
        if (!obj['testCaseList']) {
            obj['testCaseList'] = [];
        }

        let index = parseInt(keys[1], 10);
        let field = keys[2].slice(1);
        console.log(field);

        if (!obj['testCaseList'][index]) {
            obj['testCaseList'][index] = {};
        }

        obj['testCaseList'][index][field] = value;
    } else {
        let lastKey = keys.pop();
        let pointer = obj;

        keys.forEach(function(key) {
            if (!pointer[key]) {
                pointer[key] = {};
            }
            pointer = pointer[key];
        });

        pointer[lastKey] = value;
    }
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

function setSystemPath(systemNo) {
    let selectedItem = $('[data-system-no="' + systemNo + '"]');
    console.log(selectedItem);
    if (selectedItem.length) {
        let path = selectedItem.data('parent-path') || selectedItem.text();
        $('#system-select span:first-child').text(path);
    }
}

function fetchOptions() {
    $.ajax({
        url: '/projects/tests/options',
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

        // if (option.cd_dtl_no === typeSelect) {
        //     $option.attr('selected', 'selected');
        // } else if (option.cd_dtl_no === prioritySelect) {
        //     $option.attr('selected', 'selected');
        // } else if (option.cd_dtl_no === statusSelect) {
        //     $option.attr('selected', 'selected');
        // }


        $selectElement.append($option);

    });
}