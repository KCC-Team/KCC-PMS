let testCaseIdx = 0;
let unitTestIdx = 0;
let integrationTestCaseIdx = 0;

let observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
        if (mutation.addedNodes) {
            mutation.addedNodes.forEach(function(node) {
                $(node).find('.test-date').addBack('.test-date').each(function() {
                    $(this).datepicker({
                        dateFormat: "yy-mm-dd"
                    });
                });
            });
        }
    });
});

observer.observe(document.body, {
    childList: true,
    subtree: true
});

let observer_mem = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
        if (mutation.addedNodes) {
            mutation.addedNodes.forEach(function(node) {
                if (node.id === `mem_no_${testCaseIdx}`) {
                    $(node).val(event.data.member[0].name);
                }
            });
        }
    });
});

observer_mem.observe(document.body, {
    childList: true,
    subtree: true
});


$(function() {
    $('.feature-select-area').hide();
    $('.excel-area').hide();
    $('#test-case-area').hide();

    Chart.register(ChartDataLabels);
    generateCharts();
    fetchOptions();
    autoResize();

    $(".test-date").datepicker({
        dateFormat: "yy-mm-dd"
    });

    fetchMenuData().then(function (menuData) {
        createMenu(menuData);

        let systemNo = $('#systemNo').val();
        if (systemNo) {
            setSystemPath(systemNo);
        }
    });

    $('#system-select').click(function () {
        $('#system-menu').slideToggle();
    });

    $('#PMS012').change(function() {
        changeTestType($(this));
    });

    $(document).on('click', '#addRow', function() {
        if ($('#PMS012').val() === 'PMS01201') {
            $('#test-table-body-unit').append(generateUnitTestcase());
            updateTestCaseIndices($('#test-table-body-unit > tr'), 'unit');
        } else if ($('#PMS012').val() === 'PMS01202') {
            let testcaseId = $(this).data('testcase');
            $(`#test-table-body-itg-${testcaseId}`).append(generateIntegrationTestRow(testcaseId));
            updateTestCaseIndices($(`#test-table-body-itg-${testcaseId} > tr`), testcaseId);
        }
    });

    $(document).on('click', '#addTest', function() {
        $('#itg-test-area').append(generateWorkTask());
    });

    $('#test-case-area').on('click', '.addRow', function() {
        let testcaseId = $(this).data('testcase');
        $(`#test-table-body-itg-${testcaseId}`).append(generateIntegrationTestRow(testcaseId));
        updateTestCaseIndices($(`#test-table-body-itg-${testcaseId} > tr`), testcaseId);
    });

    $('#test-case-area').on('click', '.addTest', function() {
        let testcaseId = $(this).data('testcase');
        let rowId = $(this).data('row');
        let workTaskAreaId = `#itg-test-area-${testcaseId}-${rowId}`;
        $(workTaskAreaId).append(generateWorkTask());
    });

    $('.save-btn-test').click(function() {
        submitTestData();
    });

    $(document).on('click', '.unit-delete-row-btn', function() {
        if (confirm('이 행을 삭제하시겠습니까?')) {
            let $row = $(this).closest('tr');
            $row.remove();

            let $tbody = $row.closest('tbody');
            updateTestCaseIndices($tbody.find('tr'));
        }
    });

    $(document).on('click', '.itg-delete-row-btn', function() {
        if (confirm('이 행을 삭제하시겠습니까?')) {
            let $row = $(this).closest('tr');
            $row.remove();

            let $tbody = $row.closest('tbody');
            updateTestCaseIndices($tbody.find('tr'));
        }
    });
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
            toast.push({
                theme: 'danger',
                msg: '시스템 메뉴를 가져오는데 실패했습니다.'
            });
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
            $('#system-select span:first-child').text(currentPath);
            $('#systemNo').val(menuItem.systemNo);
            $('.mymenu').slideUp();
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

    $.ajax({
        url: '/projects/tests/features',
        method: 'GET',
        success: function(data) {
            const $featureSelect = $('#feature');
            console.log('data:', data);
            data.forEach(function(item) {
                const $option = $('<option>', {
                    value: item.featureNo,
                    text: item.featureName
                });
                $featureSelect.append($option);
            });
        },
    });
}

function setOptions($selectElement, options) {
    options.forEach(function(option) {

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

function changeTestType($this) {
    if ($('#testId').val() === '') {
        toast.push({
            theme: 'warning',
            msg: '테스트 ID를 먼저 입력해주세요.'
        });
        $this.val('PMS01201');
        return;
    }
    let selectedOption = $this.val();
    let html;

    if (selectedOption === 'PMS01201') {
        $('.feature-select-area').show(50);
        $('.excel-area').hide();
        html = `
            <thead>
                <tr>
                    <th class="text-nowrap" rowspan="2">순번</th>
                    <th rowspan="2">사전조건</th>
                    <th rowspan="2">테스트케이스 설명</th>
                    <th rowspan="2">수행절차 / 테스트 데이터</th>
                    <th rowspan="2">예상결과</th>
                    <th rowspan="2" style="width: 130px">케이스 작성일자</th>
                    <th rowspan="2" style="width: 130px">시험자</th>
                    <th colspan="3">테스트 결과</th>
                </tr>
                <tr>
                    <th style="width: 130px">시험 일자</th>
                    <th style="width: 130px">결과</th>
                    <th style="width: 130px">발생한 결함</th>
                </tr>
            </thead>
            <tbody id="test-table-body-unit">
        `;
        html += generateUnitTestcase();
        html += `
        </tbody>
        <tfoot>
            <tr>
                <td colspan="11">
                    <button id="addRow" style="width: 100%;">테스트 케이스 추가</button>
                </td>
            </tr>
        </tfoot>
        `;

        $('#test-case-area').html(html);
        $('#test-case-area').show(50);
        initializeSortable('test-table-body-unit');
    } else if (selectedOption === 'PMS01202') {
        $('.feature-select-area').hide();
        $('.excel-area').show(50);
        let html = `
            <div id="integration-test-container">
                <ul class="nav nav-tabs" id="integrationTestTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link add-tab" id="add-tab-button" type="button" role="tab">+</button>
                    </li>
                </ul>
                <div class="tab-content" id="integrationTestTabsContent">
                </div>
            </div>
        `;

        $('#test-case-area').html(html);
        $('#test-case-area').show(50);

        integrationTestCaseIdx = 0;
        addIntegrationTestCaseTab();

        $('#add-tab-button').off('click').on('click', function() {
            addIntegrationTestCaseTab();
        });
    }
}

function generateCharts() {
    const colors = {
        plan: '#757575',
        inProgress: '#4e7df5',
        defectOccurred: '#ff0e27',
        completed: '#4caf50',
        cancel: '#f5a65e'
    };

    const testCaseData = {
        labels: ['테스트케이스 상태'],
        datasets: [
            {
                label: '계획',
                data: [10],
                backgroundColor: colors.plan,
                hoverBackgroundColor: colors.plan
            },
            {
                label: '수행중',
                data: [15],
                backgroundColor: colors.inProgress,
                hoverBackgroundColor: colors.inProgress
            },
            {
                label: '결함발생',
                data: [5],
                backgroundColor: colors.defectOccurred,
                hoverBackgroundColor: colors.defectOccurred
            },
            {
                label: '진행완료',
                data: [20],
                backgroundColor: colors.completed,
                hoverBackgroundColor: colors.completed
            }
        ]
    };

    const defectData = {
        labels: ['결함 상태'],
        datasets: [
            {
                label: '신규',
                data: [0],
                backgroundColor: colors.defectOccurred,
                hoverBackgroundColor: colors.defectOccurred
            },
            {
                label: '취소',
                data: [0],
                backgroundColor: colors.cancel,
                hoverBackgroundColor: colors.cancel
            },
            {
                label: '진행중',
                data: [5],
                backgroundColor: colors.inProgress,
                hoverBackgroundColor: colors.inProgress
            },
            {
                label: '해결',
                data: [15],
                backgroundColor: colors.completed,
                hoverBackgroundColor: colors.completed
            }
        ]
    };

    const maxTestCaseValue = getMaxDataValue(testCaseData.datasets);
    const maxDefectValue = getMaxDataValue(defectData.datasets);

    const chartOptions = {
        maintainAspectRatio: false,
        scales: {
            x: {
                display: false,
                categoryPercentage: 0.8,
                barPercentage: 0.5
            },
            y: {
                beginAtZero: true,
                display: false,
                max: maxTestCaseValue + 3,
            }
        },
        plugins: {
            legend: {
                display: true,
                position: 'top',
                labels: {
                    font: {
                        size: 12
                    },
                    boxWidth: 19,
                    boxHeight: 10,
                    padding: 5
                },
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        let label = context.dataset.label || '';
                        let value = context.parsed.y || 0;
                        return `${label}: ${value}건`;
                    }
                }
            },
            datalabels: {
                color: '#444',
                anchor: 'end',
                align: 'start',
                offset: -19,
                font: {
                    size: 12,
                },
                formatter: function(value) {
                    return value;
                },
            }
        }
    };

    // 차트 생성
    const ctx = document.getElementById('testCaseChart').getContext('2d');
    const defect = document.getElementById('defectChart').getContext('2d');
    const testCaseChart = new Chart(ctx, {
        type: 'bar',
        data: testCaseData,
        options: chartOptions
    });
    const defectChart = new Chart(defect, {
        type: 'bar',
        data: defectData,
        options: chartOptions
    });
}

function getMaxDataValue(dataSets) {
    let max = 0;
    dataSets.forEach(dataset => {
        dataset.data.forEach(value => {
            if (value > max) {
                max = value;
            }
        });
    });
    return max;
}

window.addEventListener('message', function (event) {
    if (event.data.type.startsWith('test_')) {
        let idParts = event.data.type.split('_');

        if (idParts[1] === 'unit') {
            // 단위 테스트의 경우
            let unitTestIdx = idParts[2];
            let nameInputId = `mem_no_unit_${unitTestIdx}`;
            let idInputId = `mem_id_unit_${unitTestIdx}`;
            $(`#${nameInputId}`).val(event.data.member[0].memberName);
            $(`#${idInputId}`).val(event.data.member[0].id);
        } else {
            // 통합 테스트의 경우
            let testCaseId = idParts[1];
            let rowIdx = idParts[2];
            let nameInputId = `mem_no_${testCaseId}_${rowIdx}`;
            let idInputId = `mem_id_${testCaseId}_${rowIdx}`;
            $(`#${nameInputId}`).val(event.data.member[0].memberName);
            $(`#${idInputId}`).val(event.data.member[0].id);
        }
    }
});

function autoResize() {
    document.addEventListener('input', function(event) {
        if (event.target.matches('.auto-resize')) {
            resizeTextarea(event.target);
        }
    });

    function resizeTextarea(textarea) {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';

        let tr = textarea.closest('tr');
        if (tr) {
            tr.style.height = textarea.scrollHeight + 'px';
        }
    }
}

function generateUnitTestcase() {
    unitTestIdx++;
    return `
        <tr id="test_${unitTestIdx}_tr">
            <td>
                <div style="display: flex; align-items: center;">
                    <span class="drag-handle" style="cursor: move;">${unitTestIdx}</span>
                    <button type="button" class="unit-delete-row-btn" style="margin-left: 5px;">&times;</button>
                </div>
            </td>
            <td><textarea type="text" class="form-control auto-resize" name="precondition" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="testDetailContent" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="testProcedure" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="expectedResult" maxlength="500"></textarea></td>
            <td><input type="text" class="form-control test-date" name="writtenDate" placeholder="yyyy-mm-dd"></td>
            <td>
                <input type="hidden" id="mem_id_unit_${unitTestIdx}" name="writerId">
                <input type="text" id="mem_no_unit_${unitTestIdx}" class="form-control text-center" name="writerName" onClick="openTeamPopUp('test_unit_${unitTestIdx}')">
            </td>
            <td><input type="text" class="form-control test-date" name="testDate" placeholder="yyyy-mm-dd"></td>
            <td>
                <select name="result">
                    <option selected disabled>결과 선택</option>
                    <option value="pass">PASS</option>
                    <option value="fail">결함 발생</option>
                </select>
            </td>
            <td></td>
        </tr>
    `;
}

function generateIntegerationTest() {
    testCaseIdx++;
    return `
        <tr id="test_${testCaseIdx}_tr">
            <td><span class="drag-handle" style="cursor: move;">${testCaseIdx}</span></td>
            <td><textarea type="text" class="form-control auto-resize" name="workContent" maxlength="500"></textarea></td>
            <td><table style="width: 100%">
                <thead>
                    <th>테스트ID</th>
                    <th>테스트내용</th>
                </thead>
                <tbody id="itg-test-area">
                    `+ generateWorkTask() + `
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="11">
                            <button id="addTest">테스트 추가</button>
                        </td>
                    </tr>
                </tfoot>
            </table></td>
            <td><textarea type="text" class="form-control auto-resize" name="feature" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="testData" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="expectedResult" maxlength="500"></textarea></td>
            <td><input type="text" id="mem_no_${testCaseIdx}" class="form-control text-center" name="writer" onClick="openTeamPopUp('test_${testCaseIdx}')"></td>
            <td><input type="text" class="form-control test-date" name="testDate" placeholder="yyyy-mm-dd"></td>
            <td>
                <select>
                    <option selected disabled>결과 선택</option>
                    <option value="pass">PASS</option>
                    <option value="fail">결함 발생</option>
                </select>
            </td>
            <td></td>
        </tr>
    `;
}

function generateWorkTask() {
    return `
        <tr>
            <td><input type="text" class="form-control" name="testId" value="` + $('#testId').val() + `_${integrationTestCaseIdx}"></td>
            <td><input type="text" class="form-control" name="testContent"></td>
        </tr>
    `
}

function initializeSortable(elementId) {
    let tbody = document.getElementById(elementId);
    let sortable = Sortable.create(tbody, {
        handle: '.drag-handle',
        animation: 150,
        forceFallback: true,
        fallbackOnBody: true,
        fallbackTolerance: 5,
        onEnd: function (evt) {
            let testCaseIdMatch = elementId.match(/\d+/);
            let testCaseId = testCaseIdMatch ? testCaseIdMatch[0] : 'unit';
            updateTestCaseIndices($(`#${elementId} > tr`), testCaseId);
        },
    });
}

function updateTestCaseIndices(rows, testCaseId) {
    rows = $(rows);
    rows.each(function(index, row) {
        const seqCell = $(row).find('td:first-child .drag-handle');
        if (seqCell.length) {
            seqCell.text(index + 1);
        }

        // 전달받은 testCaseId를 사용
        row.id = `test_${testCaseId}_${index + 1}_tr`;

        const writerInput = $(row).find('input[name="writer"]');
        if (writerInput.length) {
            writerInput.attr('id', `mem_no_${testCaseId}_${index + 1}`);
            writerInput.attr('onClick', `openTeamPopUp('test_${testCaseId}_${index + 1}')`);
        }
    });
}

function addIntegrationTestCaseTab() {
    integrationTestCaseIdx++;

    let tabId = 'testcase' + integrationTestCaseIdx;
    let tabContentId = 'testcase' + integrationTestCaseIdx + '-content';

    let tabHtml = `
        <li class="nav-item" role="presentation">
            <button class="nav-link ${integrationTestCaseIdx === 1 ? 'active' : ''}" id="${tabId}-tab" data-bs-toggle="tab" data-bs-target="#${tabContentId}" type="button" role="tab" aria-controls="${tabContentId}" aria-selected="${integrationTestCaseIdx === 1 ? 'true' : 'false'}">` + $('#testId').val() + `_${integrationTestCaseIdx}</button>
        </li>
    `;

    $('#integrationTestTabs').append(tabHtml);

    let tabContentHtml = `
        <div class="tab-pane fade ${integrationTestCaseIdx === 1 ? 'show active' : ''}" id="${tabContentId}" role="tabpanel" aria-labelledby="${tabId}-tab">
            <table class="d-flex justify-content-center align-item-center">
                <tr>
                    <td class="td-title">테스트 설명</td>
                    <td style="width: 600px"><textarea class="tc-info"></textarea></td>
                    <td class="td-title">사전조건</td>
                    <td style="width: 600px"><textarea class="tc-info"></textarea></td>
                </tr> 
            </table>
            <table class="table">
                <thead>
                    <tr>
                        <th class="text-nowrap" rowspan="2">순번</th>
                        <th rowspan="2">업무처리 내용</th>
                        <th rowspan="2" style="width: 350px">테스트</th>
                        <th rowspan="2" style="width: 100px;">관련 프로그램</th>
                        <th rowspan="2">테스트 데이터</th>
                        <th rowspan="2">예상결과</th>
                        <th colspan="4">테스트 결과</th>
                    </tr>
                    <tr>
                        <th style="width: 130px">시험자</th>
                        <th style="width: 130px">시험 일자</th>
                        <th style="width: 130px">결과</th>
                        <th style="width: 100px">발생한 결함</th>
                    </tr>
                </thead>
                <tbody id="test-table-body-itg-${integrationTestCaseIdx}">
                    <!-- 테이블 행이 추가됩니다 -->
                    ${generateIntegrationTestRow(integrationTestCaseIdx)}
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="11">
                            <button class="addRow" data-testcase="${integrationTestCaseIdx}" style="width: 100%;">행 추가</button>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    `;

    $('#integrationTestTabsContent').append(tabContentHtml);

    // 새로운 테이블에 대해 Sortable 초기화
    initializeSortable(`test-table-body-itg-${integrationTestCaseIdx}`);
}

function generateIntegrationTestRow(testCaseIdx) {
    let rowIdx = $(`#test-table-body-itg-${testCaseIdx} > tr`).length + 1;
    console.log('rowIdx:', rowIdx);
    return `
        <tr id="test_${testCaseIdx}_${rowIdx}_tr">
            <td>
                <div style="display: flex; align-items: center;">
                    <span class="drag-handle" style="cursor: move;">${rowIdx}</span>
                    <button type="button" class="itg-delete-row-btn" style="margin-left: 5px;">&times;</button>
                </div>
            </td>
            <td><textarea type="text" class="form-control auto-resize" name="workContent" maxlength="500"></textarea></td>
            <td>
                <table style="width: 100%">
                    <thead>
                        <tr>
                            <th>테스트ID</th>
                            <th>테스트내용</th>
                        </tr>
                    </thead>
                    <tbody id="itg-test-area-${testCaseIdx}-${rowIdx}">
                        ${generateWorkTask()}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2">
                                <button class="addTest" data-testcase="${testCaseIdx}" data-row="${rowIdx}">테스트 추가</button>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </td>
            <td><textarea type="text" class="form-control auto-resize" name="feature" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="testData" maxlength="500"></textarea></td>
            <td><textarea type="text" class="form-control auto-resize" name="expectedResult" maxlength="500"></textarea></td>
            <td>
                <input type="hidden" id="mem_id_${testCaseIdx}_${rowIdx}" name="writerId">
                <input type="text" id="mem_no_${testCaseIdx}_${rowIdx}" class="form-control text-center" name="writerName" onClick="openTeamPopUp('test_${testCaseIdx}_${rowIdx}')">
            </td>
            <td><input type="text" class="form-control test-date" name="testDate" placeholder="yyyy-mm-dd"></td>
            <td>
                <select name="result">
                    <option selected disabled>결과 선택</option>
                    <option value="pass">PASS</option>
                    <option value="fail">결함 발생</option>
                </select>
            </td>
            <td></td>
        </tr>
    `;
}

function collectTestData() {
    let testType = $('#PMS012').val();
    let testTitle = $('#testTitle').val();
    let testId = $('#testId').val();
    let testStatus = $('#PMS013').val();
    let workSystemNo = $('#systemNo').val();
    let testStartDate = $('#testStartDate').val();
    let testEndDate = $('#testEndDate').val();
    let testContent = $('#testContent').val();

    let testData = {
        testId: testId,
        testType: testType,
        testTitle: testTitle,
        testStatus: testStatus,
        workSystemNo: workSystemNo,
        testStartDate: testStartDate,
        testEndDate: testEndDate,
        testContent: testContent,
        testCaseList: []
    };

    if (testType === 'PMS01201') {
        let rows = $('#test-table-body-unit tr');
        let featureId = $('#feature').val();
        let testDetailId = $('#testDetailId').val();

        rows.each(function(index, row) {
            let testCase = {
                testDetailId: testDetailId,
                preCondition: $(row).find('textarea[name="precondition"]').val(),
                testDetailContent: $(row).find('textarea[name="testDetailContent"]').val(),
                testProcedure: $(row).find('textarea[name="testProcedure"]').val(),
                estimatedResult: $(row).find('textarea[name="expectedResult"]').val(),
                featNumber: [featureId],
                writtenDate: $(row).find('input[name="writtenDate"]').val(),
                writerNo: $(row).find('input[name="writerId"]').val(),
                writerName: $(row).find('input[name="writerName"]').val(),
                testDate: $(row).find('input[name="testDate"]').val(),
                result: $(row).find('select[name="result"]').val(),
                defect: $(row).find('input[name="defect"]').val()
            };
            testData.testCaseList.push(testCase);
        });
    } else if (testType === 'PMS01202') {
        let tabContents = $('#integrationTestTabsContent .tab-pane');
        tabContents.each(function(index, tabContent) {
            let testCase = {
                workContent: $(tabContent).find('textarea[name="workContent"]').val(),
                tests: [],
                feature: $(tabContent).find('textarea[name="feature"]').val(),
                testData: $(tabContent).find('textarea[name="testData"]').val(),
                estimatedResult: $(tabContent).find('textarea[name="expectedResult"]').val(),
                writer: $(tabContent).find('input[name="writer"]').val(),
                testDate: $(tabContent).find('input[name="testDate"]').val(),
                result: $(tabContent).find('select[name="result"]').val(),
                defect: $(tabContent).find('input[name="defect"]').val()
            };

            let testRows = $(tabContent).find('tbody[id^="itg-test-area"] tr');
            testRows.each(function(i, testRow) {
                let test = {
                    testId: $(testRow).find('input[name="testId"]').val(),
                    testContent: $(testRow).find('input[name="testContent"]').val()
                };
                testCase.tests.push(test);
            });

            testData.testCaseList.push(testCase);
        });
    }

    return testData;
}

function submitTestData() {
    let testData = collectTestData();
    console.log('testData:', testData);
    $.ajax({
        url: '/projects/tests/test',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(testData),
        success: function(response) {
            window.location.href = '/projects/tests/test/' + response;
        },
        error: function(xhr, status, error) {
            console.error('테스트 데이터 저장 실패:', error);
        }
    });
}
