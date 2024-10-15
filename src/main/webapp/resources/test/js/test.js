const API_SERVER = 'http://localhost:8085';

$(function() {
    function updateButtonVisibility() {
        let selectedOption = $('#test-type').val();
        if (selectedOption === '0') {
            $('.tc-btn').hide();
        } else {
            $('.tc-btn').show();
        }
    }
    updateButtonVisibility();
    $('#test-type').change(updateButtonVisibility);

    let testCaseIdx = 0;
    let testCaseCnt = 1;
    let testCnt = 1;
    let workTaskCnt = 1;
    function generateUnitTestcase() {
        let testCaseId = $('#teat_id').val() + "_" + testCaseIdx;
        return `<section>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>순번</div>
                        <span>` + testCaseIdx + `</span>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트케이스 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <input type="text" name="testCaseList[` + testCaseIdx + `].testCaseId" value="${testCaseId}" disabled >
                    </div>
                </div>
                <br>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>사전조건</label></div>
                        <textarea class="test-data" name="testCaseList[` + testCaseIdx + `].preCondition" required ` + $('#disabled').val() + ` ></textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트케이스 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <textarea class="test-data" name="testCaseList[` + testCaseIdx + `].testCaseCont" ` + $('#disabled').val() + ` ></textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>수행절차</div>
                        <textarea class="test-data" name="testCaseList[` + testCaseIdx + `].preoceedCont" ` + $('#disabled').val() + ` ></textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트 데이터</label></div>
                        <textarea class="test-data" name="testCaseList[` + testCaseIdx + `].testData" ` + $('#disabled').val() + ` ></textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>예상결과</div>
                        <textarea class="test-data" name="testCaseList[` + testCaseIdx + `].estimatedResult" ` + $('#disabled').val() + ` ></textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                </div>
               </section>
               <br><hr>`;
    }

    function generateIntegrationTest() {
        let testCaseId = $('#teat_id').val() + "_" + testCaseCnt;
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
        if (selectedOption === '1') {
            html = `
                <label class="ms-4 fw-bold fs-2 text-black">
                       단위 테스트 등록</label>
               <hr>
               <div class="me-4">
                    <div class="d-flex justify-content-start"><label>기능 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                    <div class="d-flex justify-content-start">
                        <select id="feat" name="featId" required ` + $('#disabled').val() + ` >
                            <option value="" selected disabled>선택하세요.</option>
                            <option value="RSTR110"></option>
                            <option value="RSTR111"></option>
                            <option value="RSTR123"></option>
                            <option value="RSTR221"></option>
                            <option value="RSTR222"></option>
                        </select>
                    </div>
                </div><br>
            `;
            html += generateUnitTestcase();
        } else if (selectedOption === '2') {
            html = `
                <label class="ms-4 fw-bold fs-2 text-black">
                       통합 테스트 등록</label>
               <hr>
            `;
            html += generateIntegrationTest();
        }

        $('#dynamic-content').html(html);
        $(document).on('click', '.tc-btn', function() {
            if (selectedOption === '1') {
                ++testCaseIdx;
                $('#dynamic-content').append(generateUnitTestcase());
            }
            else if (selectedOption === '2') {
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
        console.log(JSON.stringify(jsonObject, null, 2))

        $.ajax({
            url: API_SERVER + '/projects/tests/register',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(jsonObject),
            success: function(response) {
                // 성공 처리
            },
            error: function(error) {
                // 에러 처리
            }
        });
    });

    $('.cancel').click(function(e) {
        e.preventDefault();
        location.href = '/projects/tests';
    });
});

function assignValue(obj, keys, value) {
    if (keys[0] === 'testCaseList') {
        // 'testCaseList'를 배열로 처리
        if (!obj['testCaseList']) {
            obj['testCaseList'] = [];
        }

        let index = parseInt(keys[1], 10); // 배열 인덱스
        let field = keys[2].slice(1); // 필드 이름
        console.log(field);

        // 인덱스 위치에 객체가 없으면 생성
        if (!obj['testCaseList'][index]) {
            obj['testCaseList'][index] = {};
        }

        obj['testCaseList'][index][field] = value;
    } else {
        // 다른 필드들은 일반적으로 처리
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
