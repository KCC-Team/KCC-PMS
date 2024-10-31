let testCaseIdx = 0;
let testCaseCnt = 1;
let testIdx = 1;
let workTaskCnt = 1;

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

// Observer 생성
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

// Observer 설정 및 시작
observer_mem.observe(document.body, {
    childList: true,
    subtree: true
});


$(function() {
    $('.feature-area').hide();
    $('#test-case-area').hide();

    Chart.register(ChartDataLabels);
    generateCharts();
    fetchOptions();

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
            console.error("Error fetching data:", error);
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
    let selectedOption = $this.val();
    let html;

    if (selectedOption === 'PMS01201') {
        $('.feature-area').show(50);
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
                    <th colspan="2">테스트 결과</th>
                </tr>
                <tr>
                    <th style="width: 130px">시험 일자</th>
                    <th style="width: 130px">결과</th>
                </tr>
            </thead>
        `;
        html += generateUnitTestcase();
    } else if (selectedOption === 'PMS01202') {
        html = `
            <label class="ms-4 fw-bold fs-2 text-black">
                   통합 테스트 등록</label>
           <hr>
        `;
        html += generateIntegrationTest();
    }

    $('#test-case-area').html(html);
    $('#test-case-area').show(50);
    // $('#dynamic-content').html(html);
    // $(document).on('click', '.tc-btn', function() {
    //     if (selectedOption === 'PMS01201') {
    //         ++testCaseIdx;
    //         $('#dynamic-content').append(generateUnitTestcase(testCaseIdx, {}));
    //     }
    //     else if (selectedOption === 'PMS01202') {
    //         ++testCaseCnt;
    //         $('#dynamic-content').append(generateIntegrationTest());
    //     }
    //     testCnt = 1;
    //     workTaskCnt = 1;
    // });
    //
    // $(document).on('click', '.add-new-work-task-btn', function() {
    //     let testCaseId = $(`#test_${testCaseCnt}`).text();
    //     testCnt = 1;
    //     let work_selector = `.work-task_${testCaseId}_${workTaskCnt}`;
    //     workTaskCnt++;
    //     let newWorkTask = generateWorkTask(testCaseId);
    //     $(`.add-new-work-task-btn`).remove();
    //     $(work_selector).after(newWorkTask);
    // });
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
    if (parseInt(event.data.type) === parseInt(`${testCaseIdx}`)) {
        $(`#mem_no_${testCaseIdx}`).val(event.data.member[0].memberName);
    }
});

function generateUnitTestcase() {
    testCaseIdx++;
    return `
        <tr>
            <td id="test_${testCaseIdx}">${testCaseIdx}</td>
            <td><input type="text" class="form-control" name="precondition"></td>
            <td><input type="text" class="form-control" name="testCaseDescription"></td>
            <td><input type="text" class="form-control" name="testProcedure"></td>
            <td><input type="text" class="form-control" name="expectedResult"></td>
            <td><input type="text" class="form-control test-date" name="writtenDate" placeholder="yyyy-mm-dd"></td>
            <td><input type="text" id="mem_no_${testCaseIdx}" class="form-control text-center" name="writer" onClick="openTeamPopUp('${testCaseIdx}')"></td>
            <td><input type="text" class="form-control test-date" name="testDate" placeholder="yyyy-mm-dd"></td>
            <td>
                <select>
                    <option value="0">PASS</option>
                    <option value="1">결함 발생</option>
                </select>
            </td>
        </tr>
    `;
}
