let testCaseIdx = 0;
let unitTestIdx = 0;
let integrationTestCaseIdx = 0;
let featureList = [];
let testCaseDataArray = [];

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
    Chart.register(ChartDataLabels);
    let pathname = window.location.pathname;
    let pathSegments = pathname.split('/');
    let lastSegment = pathSegments[pathSegments.length - 1];

    if (lastSegment === 'test' && pathSegments[pathSegments.length - 2] === 'tests') {
        $('#chartArea').hide();
    } else {
        $('#chartArea').show();
    }

    $('.feature-select-area').hide();
    $('.excel-area').hide();
    $('#test-case-area').hide();

    $(document).on('input change', 'input[name="writerName"], select[name="result"]', function() {
        collectAndProcessTestData();
        generateCharts();
    });

    fetchOptions();
    autoResize();

    $(".test-date").datepicker({
        dateFormat: "yy-mm-dd"
    });

    $('#feature').select2({
        width: '100%',
        dropdownAutoWidth: true
    });

    let testId = getTestIdFromURL();
    if (testId) {
        fetchTestData(testId).then(function(testData) {
            testCaseDataArray = testData.testCaseList;
            $('.testCase-section').css('background', '#fff');
            $('#testTitle').val(testData.testTitle);
            $('#testId').val(testData.testId);
            $('#PMS012').val(testData.testType).trigger('change');
            $('#PMS013').val(testData.testStatus);
            $('#testStartDate').val(testData.testStartDate);
            $('#testEndDate').val(testData.testEndDate);
            $('#systemNo').val(testData.workSystemNo);
            $('#testContent').val(testData.testContent);
            setSystemPath(testData.workSystemNo);

            if (testData.testType === 'PMS01201') {
                $('.feature-select-area').show(50);
                $('#testDetailId').val(testData.testCaseList[0].testDetailId);
                $('#feature').val(testData.testCaseList[0].featNumbers[0]).trigger('change');
            } else if (testData.testType === 'PMS01202') {
                $('.feature-select-area').hide();
                let featureArea = document.querySelector('.center-area');
                if (featureArea) {
                    featureArea.parentNode.removeChild(featureArea);
                }
                $('.excel-area').show(50);
            }

            collectAndProcessTestData();
            generateCharts();

            let rows = $('#test-table-body-unit > tr');
            let itg_rows = $('[id^="test-table-body-itg-"] > tr');
            if (rows.length > 0 || itg_rows.length > 0) {
                $('#PMS012').on('mousedown touchstart', function(e) {
                    e.preventDefault();
                    this.blur();
                });
            }

            return fetchFeatureData().then(function() {
                if (testData.testType === 'PMS01201') {
                    renderUnitTestCases(testData.testCaseList);
                } else if (testData.testType === 'PMS01202') {
                    renderIntegrationTestCases(testData.testCaseList);
                }
                collectAndProcessTestData();
                generateCharts();
            });
        });
    }

    fetchMenuData().then(function (menuData) {
        createMenu(menuData);

        let systemNo = $('#systemNo').val();
        if (systemNo) {
            setSystemPath(systemNo);
        }
    });

    $(document).on('change', '#test-case-area select[name="result"]', function() {
        let selectedValue = $(this).val();
        if (selectedValue === 'PMS01402') {
            let pathname = window.location.pathname;
            let pathSegments = pathname.split('/');
            let lastSegment = pathSegments[pathSegments.length - 1];

            let $tr = $(this).closest('tr');
            let testDetailNo = $tr.find('input[name="testDetailNumber"]').val();
            let testDetailId;

            // Determine the test type
            if ($('#PMS012').val() === 'PMS01201') {
                // Unit Test
                testDetailId = $('#testDetailId').val();
            } else if ($('#PMS012').val() === 'PMS01202') {
                // Integration Test
                // Find the closest tab-pane
                let $tabPane = $(this).closest('.tab-pane');
                let tabContentId = $tabPane.attr('id');
                let $tabButton = $(`#integrationTestTabs button[aria-controls="${tabContentId}"]`);
                testDetailId = $tabButton.text().trim();
            }

            if (testDetailNo) {
                let popupUrl = '/projects/defects/defect?test=' + lastSegment +
                    '&testDetailNo=' + encodeURIComponent(testDetailNo) +
                    '&testDetailId=' + encodeURIComponent(testDetailId);
                window.open(popupUrl, 'popup', 'width=1150,height=810');
            } else {
                console.error('Test case ID not found.');
            }
        }
    });

    $(document).on('change', '.feature-itg', function() {
        const $select = $(this);
        const selectedFeatureId = $select.val();

        if (!selectedFeatureId) {
            return;
        }

        const featureName = $select.find('option:selected').text();
        const $row = $select.closest('tr');
        const $selectedFeaturesContainer = $row.find('.selected-features');

        let selectedFeatures = $row.data('selectedFeatures') || [];

        // 데이터 타입 일치 확인 (모두 문자열로 변환)
        selectedFeatures = selectedFeatures.map(String);

        if (selectedFeatures.includes(selectedFeatureId)) {
            toast.push({
                theme: 'warning',
                msg: '이미 선택된 기능입니다.'
            });
            return;
        }

        const $label = $('<span>', {
            class: 'feature-label',
            text: featureName
        }).attr('data-feature-id', selectedFeatureId); // attr 사용

        const $removeBtn = $('<label>', {
            class: 'remove-feature-btn',
            text: '×'
        });

        $label.append($removeBtn);
        $selectedFeaturesContainer.append($label);

        $select.val(null);

        selectedFeatures.push(selectedFeatureId);
        $row.data('selectedFeatures', selectedFeatures);
    });

    $(document).on('click', '.remove-feature-btn', function() {
        const $removeBtn = $(this);
        const $label = $removeBtn.parent();
        const featureId = $label.attr('data-feature-id'); // attr 사용
        const $row = $removeBtn.closest('tr');

        $label.remove();

        let selectedFeatures = $row.data('selectedFeatures') || [];

        // 데이터 타입 일치 확인 (모두 문자열로 변환)
        selectedFeatures = selectedFeatures.map(String);
        selectedFeatures = selectedFeatures.filter(function(id) {
            return id !== featureId;
        });

        $row.data('selectedFeatures', selectedFeatures);
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

            collectAndProcessTestData();
            generateCharts();
        } else if ($('#PMS012').val() === 'PMS01202') {
            let testcaseId = $(this).data('testcase');
            let rowIdx = $(`#test-table-body-itg-${testcaseId} > tr`).length + 1;;
            $(`#test-table-body-itg-${testcaseId}`).append(generateIntegrationTestRow(testcaseId, rowIdx));
            updateTestCaseIndices($(`#test-table-body-itg-${testcaseId} > tr`), testcaseId);

            collectAndProcessTestData();
            generateCharts();
            fetchFeatureData();
        }
    });

    $(document).on('click', '#addTest', function() {
        $('#itg-test-area').append(generateWorkTask());
    });

    $(document).on('click', '.addRow', function() {
        let testcaseId = $(this).data('testcase');
        let rowIdx = $(`#test-table-body-itg-${testcaseId} > tr`).length + 1;
        $(`#test-table-body-itg-${testcaseId}`).append(generateIntegrationTestRow(testcaseId, null, rowIdx));
        updateTestCaseIndices($(`#test-table-body-itg-${testcaseId} > tr`), testcaseId);
        fetchFeatureData();
    });

    $('#test-case-area').on('click', '.addTest', function() {
        let testcaseId = $(this).data('testcase');
        let rowId = $(this).data('row');
        console.log(`#itg-test-area-${testcaseId}-${rowId}`);
        let workTaskAreaId = `#itg-test-area-${testcaseId}-${rowId}`;
        $(workTaskAreaId).append(generateWorkTask());
    });

    $('.save-btn-test').click(function() {
        submitTestData(lastSegment);
    });

    $(document).on('click', '.unit-delete-row-btn', function() {
        confirmationDialog('이 행을 삭제하시겠습니까?').then((result) => {
            if (result.isConfirmed) {
                $(this).closest('tr').remove();
                updateTestCaseIndices($('#test-table-body-unit > tr'), 'unit');

                collectAndProcessTestData();
                generateCharts();
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });

    $(document).on('click', '.itg-delete-row-btn', function() {
        confirmationDialog('이 행을 삭제하시겠습니까?').then((result) => {
            if (result.isConfirmed) {
                let $row = $(this).closest('tr');
                let testcaseId = $row.closest('tbody').attr('id').split('-').pop();
                $row.remove();

                updateTestCaseIndices($(`#test-table-body-itg-${testcaseId} > tr`), testcaseId);

                collectAndProcessTestData();
                generateCharts();
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });

    $(document).on('click', '.delete-work-task-btn', function() {
        const $row = $(this).closest('tr');
        $row.remove();
    });

    $(document).on('input change', '#test-table-body-unit input[name="writerName"], #test-table-body-unit select[name="result"]', function() {
        collectAndProcessTestData();
        generateCharts();
    });

    $(document).on('input change', 'tbody[id^="test-table-body-itg-"] input[name="writerName"], tbody[id^="test-table-body-itg-"] select[name="result"]', function() {
        collectAndProcessTestData();
        generateCharts();
    });

    $('.delete-btn-test').click(function() {
        confirmationDialog('테스트를 삭제하시겠습니까?').then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/projects/tests/' + lastSegment,
                    method: 'DELETE',
                    success: function(response) {
                        window.location.href = '/projects/tests?toastMsg=테스트가 삭제되었습니다.';
                    },
                    error: function(error) {
                        toast.push({
                            theme: 'danger',
                            msg: '테스트 삭제에 실패했습니다.'
                        });
                    }
                });
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });
});

function clearWriter(type, TestIdx) {
    if (type === 'unit') {
        document.getElementById('mem_id_unit_' + TestIdx).value = '';
        document.getElementById('mem_no_unit_' + TestIdx).value = '';
    } else {
        document.getElementById('mem_id_' + TestIdx).value = '';
        document.getElementById('mem_no_' + TestIdx).value = '';
    }
    collectAndProcessTestData();
    generateCharts();
}

function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
        method: 'GET',
        dataType: 'json'
    }).done(function(data) {
        return data;
    }).fail(function(error) {
        toast.push({
            theme: 'danger',
            msg: '시스템 메뉴를 가져오는데 실패했습니다.'
        });
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

function fetchFeatureData() {
    return $.ajax({
        url: '/projects/tests/features',
        method: 'GET'
    }).done(function(data) {
        featureList = data;

        $('.feature-itg').each(function() {
            const $featureSelect = $(this);
            $featureSelect.empty();
            $featureSelect.append('<option value="" selected disabled>기능 선택</option>');

            data.forEach(function(item) {
                const $option = $('<option>', {
                    value: item.featureNo,
                    text: item.featureName
                });
                $featureSelect.append($option);
            });

            $featureSelect.select2({
                width: '100%',
                dropdownAutoWidth: true
            });
        });
    }).fail(function(error) {
        console.error('기능 데이터를 가져오는데 실패했습니다.', error);
    });
}

function setOptions($selectElement, options) {
    options.forEach(function(option) {

        const $option = $('<option>', {
            value: option.cd_dtl_no,
            text: option.cd_dtl_nm
        });

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

    $('.excel-area').show(50);
    $('.testCase-section').css('background', '#fff');
    if (selectedOption === 'PMS01201') {
        $('.feature-select-area').show(50);
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

    collectAndProcessTestData();
    generateCharts();
}

function generateCharts() {
    // 수집된 데이터를 사용하여 차트 생성
    let counts = window.testCaseCounts || {
        planCount: 0,
        inProgressCount: 0,
        defectOccurredCount: 0,
        completedCount: 0
    };

    let defectCounts = window.defectCounts || {
        newDefects: 0,
        canceledDefects: 0,
        inProgressDefects: 0,
        resolvedDefects: 0
    };

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
                data: [counts.planCount],
                backgroundColor: colors.plan,
                hoverBackgroundColor: colors.plan
            },
            {
                label: '수행중',
                data: [counts.inProgressCount],
                backgroundColor: colors.inProgress,
                hoverBackgroundColor: colors.inProgress
            },
            {
                label: '결함발생',
                data: [counts.defectOccurredCount],
                backgroundColor: colors.defectOccurred,
                hoverBackgroundColor: colors.defectOccurred
            },
            {
                label: '진행완료',
                data: [counts.completedCount],
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
                data: [defectCounts.newDefects],
                backgroundColor: colors.defectOccurred,
                hoverBackgroundColor: colors.defectOccurred
            },
            {
                label: '취소',
                data: [defectCounts.canceledDefects],
                backgroundColor: colors.cancel,
                hoverBackgroundColor: colors.cancel
            },
            {
                label: '진행중',
                data: [defectCounts.inProgressDefects],
                backgroundColor: colors.inProgress,
                hoverBackgroundColor: colors.inProgress
            },
            {
                label: '해결',
                data: [defectCounts.resolvedDefects],
                backgroundColor: colors.completed,
                hoverBackgroundColor: colors.completed
            }
        ]
    };

    const maxTestCaseValue = getMaxDataValue(testCaseData.datasets);
    const maxDefectValue = getMaxDataValue(defectData.datasets);
    const maxValue = Math.max(maxTestCaseValue, maxDefectValue) + 3;

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
                max: maxValue,
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

    // 기존 차트가 있으면 파괴
    if (window.testCaseChartInstance) {
        window.testCaseChartInstance.destroy();
    }
    if (window.defectChartInstance) {
        window.defectChartInstance.destroy();
    }

    // Create charts
    const ctx = document.getElementById('testCaseChart').getContext('2d');
    const defectCtx = document.getElementById('defectChart').getContext('2d');

    window.testCaseChartInstance = new Chart(ctx, {
        type: 'bar',
        data: testCaseData,
        options: chartOptions
    });

    window.defectChartInstance = new Chart(defectCtx, {
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
        collectAndProcessTestData();
        generateCharts();
    }
});

function autoResize() {
    document.addEventListener('input', function(event) {
        if (event.target.matches('.')) {
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

function generateUnitTestcase(testCaseData, index) {
    unitTestIdx = index || (unitTestIdx + 1);
    testCaseData = testCaseData || {};

    return `
        <tr id="test_${unitTestIdx}_tr">
            <td>
                <div style="display: flex; align-items: center;">
                <input type="hidden" name="testDetailNumber" value="${testCaseData.testDetailNumber || ''}">
                    <span class="drag-handle" style="cursor: move;">${unitTestIdx}</span>
                    <label class="unit-delete-row-btn" style="margin-left: 5px;">&times;</label>
                </div>
            </td>
            <td><textarea class="auto-resize" name="precondition" maxlength="500">${testCaseData.preCondition || ''}</textarea></td>
            <td><textarea class="auto-resize" name="testDetailContent" maxlength="500">${testCaseData.testDetailContent || ''}</textarea></td>
            <td><textarea class="auto-resize" name="testProcedure" maxlength="500">${testCaseData.testProcedure || ''}</textarea></td>
            <td><textarea class="auto-resize" name="expectedResult" maxlength="500">${testCaseData.estimatedResult || ''}</textarea></td>
            <td><input type="text" class="test-date" name="writtenDate" placeholder="yyyy-mm-dd" value="${testCaseData.writtenDate || ''}"></td>
            <td>
                <div style="display: flex; align-items: center;">
                    <input type="hidden" id="mem_id_unit_${unitTestIdx}" name="writerNo" value="${testCaseData.writerNo || ''}">
                    <input type="text" id="mem_no_unit_${unitTestIdx}" class="text-center" name="writerName" readonly onClick="openTeamPopUp('test_unit_${unitTestIdx}')" value="${testCaseData.writerName || ''}">
                    <label class="clear-btn" onclick="clearWriter('unit', ${unitTestIdx})">&times;</label>
                </div>
            </td>
            <td><input type="text" class="test-date" name="testDate" placeholder="yyyy-mm-dd" value="${testCaseData.testDate || ''}" readonly></td>
            <td>
                <select name="result">
                    <option ${!testCaseData.result ? 'selected' : ''}>결과 선택</option>
                    <option value="PMS01401" ${testCaseData.result === 'PMS01401' ? 'selected' : ''}>PASS</option>
                    <option value="PMS01402" ${testCaseData.result === 'PMS01402' ? 'selected' : ''}>결함 발생</option>
                </select>
            </td>
            <td>` + generateDefect(testCaseData.defectNos) + `</td>
        </tr>
    `;
}

function generateDefect(defectData) {
    let html = '';
    if (!defectData) {
        return html;
    }
    for (let defect of defectData) {
        html += `
            <a href="#" onclick="openDefectPopup(${defect.defectNumber})" class="defect-badge">
                ${defect.defectId}
            </a>
            <input type="hidden" name="defectStatusCode" value="${defect.defectStatusCode}"/>
        `;
    }
    return html;
}

function openDefectPopup(defectNumber) {
    window.open('/projects/defects/' + defectNumber, 'popup', 'width=1150,height=810');
}

function renderIntegrationTestCases(testCaseList) {
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

    testCaseList.forEach((testCaseData) => {
        addIntegrationTestCaseTab(testCaseData);
    });

    $('#add-tab-button').off('click').on('click', function() {
        addIntegrationTestCaseTab();
    });
}

function generateWorkTask(test) {
    test = test || {};
    return `
        <tr>
            <td><input type="text" class="form-control" name="testId" value="${test.testId || ''}"></td>
            <td class="d-flex justify-content-center align-items-center">
                <input type="text" class="form-control" name="testStageContent" value="${test.testStageContent || ''}">
                <label class="delete-work-task-btn">&times;</label>
            </td>
        </tr>
    `;
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
            let itemEl = evt.item; // 드래그된 행
            let oldIndex = evt.oldIndex; // 이전 인덱스
            let newIndex = evt.newIndex; // 새로운 인덱스

            console.log('swapRowData 호출됨:', oldIndex, newIndex);

            // 이동된 두 행의 데이터를 교환
            swapRowData(tbody.rows[oldIndex], tbody.rows[newIndex]);

            // 시각적인 순번 업데이트
            updateVisualIndices(tbody);
        },
    });
}

function updateVisualIndices(tbody) {
    $(tbody).children('tr').each(function(index, row) {
        let $row = $(row);
        let seqCell = $row.find('td:first-child .drag-handle');
        if (seqCell.length) {
            seqCell.text(index + 1);
        }
    });
}

function swapRowData(row1, row2) {
    let $row1 = $(row1);
    let $row2 = $(row2);

    // 각 행의 데이터를 객체로 직렬화
    let data1 = serializeRowData($row1);
    let data2 = serializeRowData($row2);

    // 데이터 교환
    deserializeRowData($row1, data2);
    deserializeRowData($row2, data1);
}

function serializeRowData($row) {
    let data = {};
    $row.find('input, textarea, select').each(function() {
        let $elem = $(this);
        let name = $elem.attr('name');
        data[name] = $elem.val();
    });
    return data;
}

function deserializeRowData($row, data) {
    $row.find('input, textarea, select').each(function() {
        let $elem = $(this);
        let name = $elem.attr('name');
        if (data.hasOwnProperty(name)) {
            $elem.val(data[name]);
        }
    });
}

function updateTestCaseIndices(rows, testCaseId) {
    rows = $(rows);
    rows.each(function(index, row) {
        let newRowIdx = index + 1;
        const $row = $(row);

        const seqCell = $row.find('td:first-child .drag-handle');
        if (seqCell.length) {
            seqCell.text(newRowIdx);
        }

        row.id = `test_${testCaseId}_${newRowIdx}_tr`;

        const writerInput = $row.find('input[name="writerName"]');
        if (writerInput.length) {
            writerInput.attr('id', `mem_no_${testCaseId}_${newRowIdx}`);
            writerInput.attr('onClick', `openTeamPopUp('test_${testCaseId}_${newRowIdx}')`);
        }

        const writerNoInput = $row.find('input[name="writerNo"]');
        if (writerNoInput.length) {
            writerNoInput.attr('id', `mem_id_${testCaseId}_${newRowIdx}`);
        }

        const $workTaskTbody = $row.find(`tbody[id^="itg-test-area-"]`);
        if ($workTaskTbody.length) {
            let newTbodyId = `itg-test-area-${testCaseId}-${newRowIdx}`;
            $workTaskTbody.attr('id', newTbodyId);
        }

        const $addTestButton = $row.find('.addTest');
        if ($addTestButton.length) {
            $addTestButton.attr('data-testcase', testCaseId);
            $addTestButton.attr('data-row', newRowIdx);
        }
    });
}

function renderUnitTestCases(testCaseList) {
    let html = `
        <thead>
            <tr>
                <th class="text-nowrap" rowspan="2">순번</th>
                <th rowspan="2">사전조건</th>
                <th rowspan="2">테스트케이스 설명</th>
                <th rowspan="2">수행절차 / 테스트 데이터</th>
                <th rowspan="2">예상결과</th>
                <th rowspan="2" style="width: 130px">케이스 작성일자</th>
                <th rowspan="2" style="width: 100px">시험자</th>
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

    testCaseList.forEach((testCase, index) => {
        html += generateUnitTestcase(testCase, index + 1);
    });

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
}

function generateIntegrationTestContent(testCaseData, testCaseIdx) {
    testCaseData = testCaseData || {};
    let workContent = testCaseData.workContent || '';
    let feature = testCaseData.feature || '';
    let testData = testCaseData.testData || '';
    let estimatedResult = testCaseData.estimatedResult || '';
    let writerName = testCaseData.writerName || '';
    let writerNo = testCaseData.writerNo || '';
    let testDate = testCaseData.testDate || '';
    let result = testCaseData.result || '';

    let contentHtml = `
        <table class="d-flex justify-content-center align-item-center">
            <tr>
                <td class="td-title text-nowrap">테스트 케이스 설명</td>
                <td style="width: 600px">
                    <input type="hidden" name="testDetailNumber" value="${testCaseData.testDetailNumber || ''}">
                    <textarea class="tc-info" name="testDetailContent">${testCaseData.testDetailContent || ''}</textarea>
                </td>
                <td class="td-title">사전조건</td>
                <td style="width: 600px"><textarea class="tc-info" name="preCondition">${testCaseData.preCondition || ''}</textarea></td>
            </tr> 
        </table>
        <table>
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
                    <th style="width: 100px">시험자</th>
                    <th style="width: 125px">시험 일자</th>
                    <th style="width: 100px">결과</th>
                    <th style="width: 100px">발생한 결함</th>
                </tr>
            </thead>
            <tbody id="test-table-body-itg-${testCaseIdx}">
    `;

    if (testCaseData.testCaseDetails && testCaseData.testCaseDetails.length > 0) {
        testCaseData.testCaseDetails.forEach((rowData, index) => {
            let rowIdx = index + 1;
            contentHtml += generateIntegrationTestRow(testCaseIdx, rowData, rowIdx);
        });
    } else {
        let rowIdx = 1;
        contentHtml += generateIntegrationTestRow(testCaseIdx, null, rowIdx);
    }
    fetchFeatureData();

    contentHtml += `
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="11">
                        <button class="addRow" data-testcase="${testCaseIdx}" style="width: 100%;">행 추가</button>
                    </td>
                </tr>
            </tfoot>
        </table>
    `;

    return contentHtml;
}

function addIntegrationTestCaseTab(testCaseData) {
    integrationTestCaseIdx++;

    let tabId = 'testcase' + integrationTestCaseIdx;
    let tabContentId = 'testcase' + integrationTestCaseIdx + '-content';

    let tabTitle = testCaseData ? testCaseData.testId || ($('#testId').val() + '_' + integrationTestCaseIdx) : ($('#testId').val() + '_' + integrationTestCaseIdx);

    let tabHtml = `
        <li class="nav-item" role="presentation">
            <button class="nav-link ${integrationTestCaseIdx === 1 ? 'active' : ''}" id="${tabId}-tab" data-bs-toggle="tab" data-bs-target="#${tabContentId}" type="button" role="tab" aria-controls="${tabContentId}" aria-selected="${integrationTestCaseIdx === 1 ? 'true' : 'false'}">${tabTitle}</button>
        </li>
    `;

    $('#integrationTestTabs').append(tabHtml);
    let tabContentHtml = `
        <div class="tab-pane fade ${integrationTestCaseIdx === 1 ? 'show active' : ''}" id="${tabContentId}" role="tabpanel" aria-labelledby="${tabId}-tab">
            ${generateIntegrationTestContent(testCaseData, integrationTestCaseIdx)}
        </div>
    `;

    $('#integrationTestTabsContent').append(tabContentHtml);
    initializeSortable(`test-table-body-itg-${integrationTestCaseIdx}`);
}

function generateIntegrationTestRow(testCaseIdx, rowData, rowIdx) {
    rowData = rowData || {};

    let selectedFeaturesHtml = '';
    let selectedFeatures = rowData.featNumbers || [];

    if (selectedFeatures.length > 0 && featureList.length > 0) {
        selectedFeatures.forEach(function(featureId) {
            let feature = featureList.find(f => f.featureNo === featureId);
            if (feature) {
                let featureName = feature.featureName;
                selectedFeaturesHtml += `
                    <span class="feature-label" data-feature-id="${featureId}">
                        ${featureName}
                        <label class="remove-feature-btn">&times;</label>
                    </span>
                `;
            }
        });
    }

    // 기능 선택 셀렉트박스 옵션 생성
    let featureOptions = '<option value="" selected disabled>기능 선택</option>';
    if (featureList.length > 0) {
        featureList.forEach(function(feature) {
            featureOptions += `<option value="${feature.featureNo}">${feature.featureName}</option>`;
        });
    }

    console.log(rowData)
    rowData.testDate = (rowData.testDate?.substring(0, 10)) ?? '';
    return `
        <tr id="test_${testCaseIdx}_${rowIdx}_tr">
            <td>
                <div style="display: flex; align-items: center;">
                    <input type="hidden" name="testDetailNumber" value="${rowData.testDetailNumber || ''}">
                    <span class="drag-handle" style="cursor: move;">${rowIdx}</span>
                    <label class="itg-delete-row-btn">&times;</label>
                </div>
            </td>
            <td>
                <textarea class="auto-resize" name="workContent" maxlength="500">${rowData.workContent || ''}</textarea>
            </td>
            <td>
                <table style="width: 100%">
                    <thead>
                        <tr>
                            <th>테스트ID</th>
                            <th>테스트내용</th>
                        </tr>
                    </thead>
                    <tbody id="itg-test-area-${testCaseIdx}-${rowIdx}">
                        ${generateWorkTasks(rowData.tests)}
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
            <td>
                <select class="feature-itg" name="taskSelect">
                    ${featureOptions}
                </select>
                <div class="selected-features d-flex flex-column">
                    ${selectedFeaturesHtml}
                </div>
            </td>
            <td>
                <textarea class="auto-resize" name="testData" maxlength="500">${rowData.testData || ''}</textarea>
            </td>
            <td>
                <textarea class="auto-resize" name="expectedResult" maxlength="500">${rowData.estimatedResult || ''}</textarea>
            </td>
            <td class="writer-area">
                <div style="display: flex; align-items: center;">
                    <input type="hidden" id="mem_id_${testCaseIdx}_${rowIdx}" name="writerNo" value="${rowData.writerNo || ''}">
                    <input type="text" id="mem_no_${testCaseIdx}_${rowIdx}" class="text-center" name="writerName" readonly onClick="openTeamPopUp('test_${testCaseIdx}_${rowIdx}')" value="${rowData.writerName || ''}">
                    <label class="clear-btn" onclick="clearWriter('itg', '${testCaseIdx}_${rowIdx}')">&times;</label>
                </div>
            </td>
            <td>
                <input type="text" class="test-date" name="testDate" placeholder="yyyy-mm-dd" value="${rowData.testDate || ''}" readonly>
            </td>
            <td>
                <select name="result">
                    <option ${!rowData.result ? 'selected' : ''}>결과 선택</option>
                    <option value="PMS01401" ${rowData.result === 'PMS01401' ? 'selected' : ''}>PASS</option>
                    <option value="PMS01402" ${rowData.result === 'PMS01402' ? 'selected' : ''}>결함 발생</option>
                </select>
            </td>
            <td>
                ${generateDefect(rowData.defectNos)}
            </td>
        </tr>
    `;
}

function generateWorkTasks(tests) {
    let html = '';
    if (tests && tests.length > 0) {
        tests.forEach((test) => {
            html += `
                <tr>
                    <td>
                        <input type="hidden" name="testDetailNumber" value="${test.testDetailNumber || ''}">
                        <input type="text" class="form-control" name="testId" value="${test.testId || ''}">
                    </td>
                    <td class="d-flex justify-content-center align-items-center">
                        <input type="text" class="form-control" name="testStageContent" value="${test.testStageContent || ''}">
                        <label class="delete-work-task-btn">&times;</label>
                    </td>
                </tr>
                
            `;
        });
    } else {
        html += generateWorkTask();
    }
    return html;
}

function collectTestData(lastSegment) {
    let testType = $('#PMS012').val();
    let testTitle = $('#testTitle').val();
    let testId = $('#testId').val();
    let testStatus = $('#PMS013').val();
    let workSystemNo = $('#systemNo').val();
    let testStartDate = $('#testStartDate').val();
    let testEndDate = $('#testEndDate').val();
    let testContent = $('#testContent').val();

    let testData = {
        testNumber: lastSegment,
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
                testDetailNumber: $(row).find('input[name="testDetailNumber"]').val(),
                testDetailId: testDetailId,
                preCondition: $(row).find('textarea[name="precondition"]').val(),
                testDetailContent: $(row).find('textarea[name="testDetailContent"]').val(),
                testProcedure: $(row).find('textarea[name="testProcedure"]').val(),
                estimatedResult: $(row).find('textarea[name="expectedResult"]').val(),
                featNumbers: [featureId],
                writtenDate: $(row).find('input[name="writtenDate"]').val(),
                writerNo: $(row).find('input[name="writerNo"]').val(),
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
            let tabContentId = $(tabContent).attr('id');
            let tabButton = $(`#integrationTestTabs button[aria-controls="${tabContentId}"]`);
            let testId = tabButton.text().trim();

            let testCase = {
                testDetailNumber: $(tabContent).find('input[name="testDetailNumber"]').val(),
                testDetailId: testId,
                testDetailContent: $(tabContent).find('textarea[name="testDetailContent"]').val(),
                preCondition: $(tabContent).find('textarea[name="preCondition"]').val(),
                testCaseDetails: []
            };

            let rows = $(tabContent).find(`tbody[id^="test-table-body-itg-${index + 1}"] > tr`);
            rows.each(function(i, row) {
                let testCaseDetail = {
                    testDetailNumber: $(row).find('input[name="testDetailNumber"]').val(),
                    workContent: $(row).find('textarea[name="workContent"]').val(),
                    testData: $(row).find('textarea[name="testData"]').val(),
                    estimatedResult: $(row).find('textarea[name="expectedResult"]').val(),
                    writerNo: $(row).find('input[name="writerNo"]').val(),
                    writerName: $(row).find('input[name="writerName"]').val(),
                    testDate: $(row).find('input[name="testDate"]').val().substring(0, 10),
                    result: $(row).find('select[name="result"]').val(),
                    featNumbers: [], // 기능 목록
                    defectNos: [], // 결함 목록
                    tests: [] // 하위 테스트 목록
                };

                let featureLabels = $(row).find('.selected-features .feature-label');
                featureLabels.each(function(j, label) {
                    let featureId = $(label).attr('data-feature-id');
                    testCaseDetail.featNumbers.push(parseInt(featureId));
                });

                let defectLinks = $(row).find('td:last-child a.defect-badge');
                defectLinks.each(function(j, defectLink) {
                    let defectId = $(defectLink).text().trim();
                    testCaseDetail.defectNos.push({defectId});
                });

                let testRows = $(row).find(`tbody[id^="itg-test-area-${index + 1}-${i + 1}"] > tr`);
                testRows.each(function(k, testRow) {
                    let test = {
                        testDetailNumber: $(testRow).find('input[name="testDetailNumber"]').val(),
                        testId: $(testRow).find('input[name="testId"]').val(),
                        testStageContent: $(testRow).find('input[name="testStageContent"]').val()
                    };
                    testCaseDetail.tests.push(test);
                });

                testCase.testCaseDetails.push(testCaseDetail);
            });

            testData.testCaseList.push(testCase);
        });
    }

    return {
        testData: testData,
        type: testType
    };
}

function submitTestData(lastSegment) {
    let testData = collectTestData(lastSegment);
    console.log(testData.testData);
    if (testData.type === 'PMS01201') {
        // 숫자가 있으면 수정, 없으면 저장
        if (!isNaN(Number(lastSegment))) {
            $.ajax({
                url: '/projects/tests/' + lastSegment + "?type=y",
                method: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(testData.testData),
                success: function (response) {
                    window.location.href = '/projects/tests/' + response;
                },
                error: function (xhr, status, error) {
                    console.error('테스트 데이터 수정 실패:', error);
                }
            });
        } else {
            testData.testData.testNumber = null;
            $.ajax({
                url: '/projects/tests/test?type=n',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(testData.testData),
                success: function (response) {
                    window.location.href = '/projects/tests/' + response;
                },
                error: function (xhr, status, error) {
                    console.error('테스트 데이터 저장 실패:', error);
                }
            });
        }
    } else {
        if (!isNaN(Number(lastSegment))) {
            $.ajax({
                url: '/projects/tests/' + lastSegment + "?type=y",
                method: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(testData.testData),
                success: function (response) {
                    window.location.href = '/projects/tests/' + response;
                },
                error: function (xhr, status, error) {
                    console.error('테스트 데이터 수정 실패:', error);
                }
            });
        } else {
            testData.testData.testNumber = null;
            $.ajax({
                url: '/projects/tests/test?type=n',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(testData.testData),
                success: function (response) {
                    window.location.href = '/projects/tests/' + response;
                },
                error: function (xhr, status, error) {
                    console.error('테스트 데이터 저장 실패:', error);
                }
            });
        }
    }
}

function getTestIdFromURL() {
    let pathname = window.location.pathname;
    let pathSegments = pathname.split('/');
    let testId = pathSegments[pathSegments.length - 1];
    // testId가 숫자인지 확인
    if (!isNaN(testId)) {
        return testId;
    } else {
        return null;
    }
}

function fetchTestData(testId) {
    return $.ajax({
        url: '/projects/tests/api/' + testId,
        method: 'GET',
        dataType: 'json'
    }).done(function(data) {
        return data;
    }).fail(function(xhr, status, error) {
        console.error('테스트 데이터를 가져오는데 실패했습니다.', error);
    });
}


function collectAndProcessTestData() {
    let planCount = 0;
    let inProgressCount = 0;
    let defectOccurredCount = 0;
    let completedCount = 0;

    // Defect counts
    let defectCounts = {
        newDefects: 0,
        canceledDefects: 0,
        inProgressDefects: 0,
        resolvedDefects: 0
    };

    let testType = $('#PMS012').val();

    if (testType === 'PMS01201') {
        let rows = $('#test-table-body-unit > tr');
        rows.each(function() {
            let testerName = $(this).find('input[name="writerName"]').val();
            let result = $(this).find('select[name="result"]').val();

            if (!testerName) {
                planCount++;
            } else if (!result || result === '결과 선택') {
                inProgressCount++;
            } else if (result === 'PMS01402') {
                defectOccurredCount++;

                // Collect defect status code from the test case
                let defectStatusCode = $(this).find('input[name="defectStatusCode"]').val();
                updateDefectCounts(defectCounts, defectStatusCode);
            } else if (result === 'PMS01401') {
                completedCount++;
            }
        });
    } else if (testType === 'PMS01202') {
        let tabContents = $('#integrationTestTabsContent .tab-pane');
        tabContents.each(function() {
            // 각 탭 내의 테스트 케이스 행들을 선택
            let rows = $(this).find('tbody[id^="test-table-body-itg-"] > tr');
            rows.each(function() {
                let testerName = $(this).find('input[name="writerName"]').val();
                let result = $(this).find('select[name="result"]').val();

                if (!testerName) {
                    planCount++;
                } else if (!result || result === '결과 선택') {
                    inProgressCount++;
                } else if (result === 'PMS01402') {
                    defectOccurredCount++;

                    // Collect defect status code from the test case
                    let defectStatusCode = $(this).find('input[name="defectStatusCode"]').val();
                    updateDefectCounts(defectCounts, defectStatusCode);
                } else if (result === 'PMS01401') {
                    completedCount++;
                }
            });
        });
    }

    window.testCaseCounts = {
        planCount,
        inProgressCount,
        defectOccurredCount,
        completedCount
    };

    // Store defect counts globally
    window.defectCounts = defectCounts;
}

function updateDefectCounts(defectCounts, defectStatusCode) {
    switch (defectStatusCode) {
        case 'PMS00701':
            defectCounts.newDefects++;
            break;
        case 'PMS00704':
            defectCounts.canceledDefects++;
            break;
        case 'PMS00702':
            defectCounts.inProgressDefects++;
            break;
        case 'PMS00703':
            defectCounts.resolvedDefects++;
            break;
        default:
            break;
    }
}

function confirmationDialog(text = "이 작업을 진행하시겠습니까?") {
    return Swal.fire({
        title: "확인",
        text: text,
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "확인",
        cancelButtonText: "취소",
    });
}
