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

    let cnt = 1;
    let testCaseCnt = 1;
    let testCnt = 1;
    let workTaskCnt = 1;
    function generateUnitTestcase() {
        return `<section>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>순번</div>
                        <span>` + cnt + `</span>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트케이스 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <input type="text" value="" required ` + $('#disabled').val() + `>
                    </div>
                </div>
                <br>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>사전조건</label></div>
                        <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트케이스 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                        <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>수행절차</div>
                        <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                    </div>&nbsp;&nbsp;&nbsp;
                    <div class="ms-4">
                        <div class="d-flex justify-content-start"><label>테스트 데이터</label></div>
                        <textarea class="test-data"` + $('#disabled').val() + `></textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="me-4">
                        <div class="d-flex justify-content-start"><label>수행절차</div>
                        <textarea class="test-data"></textarea>
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
                            <span>` + cnt + `</span>
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

    $('#test-type').change(function() {
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
                        <select id="pri_cd" name="pri_cd" required ` + $('#disabled').val() + ` >
                            <option value="">선택하세요.</option>
                            <option value="001">즉시</option>
                            <option value="002">긴급</option>
                            <option value="003">높음</option>
                            <option value="004">보통</option>
                            <option value="005">낮음</option>
                        </select>&nbsp;&nbsp;&nbsp;
                        <button class="custom-button">&nbsp;&nbsp;&nbsp;찾기&nbsp;&nbsp;&nbsp;</button>
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
                ++cnt;
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
            console.log(`work-task_${testCaseId}_${workTaskCnt}`);
            $(work_selector).after(newWorkTask);
        });
    });

    $('#dynamic-content').on('click', '.add-test-detail', function() {
        let testCaseId = $(`#test_` + testCaseCnt).text();
        console.log(testCaseId);
        if (testCaseId) {
            let newDetail = generateTestDetails(testCaseId);
            $(this).before(newDetail);
            $('.test-area').scrollTop($('.test-area').height() * $('.test-area').height());
        }
    });

    $('.add-new-integration-test').on('click', function() {
        $('#dynamic-content').append(generateIntegrationTest());
    });
});