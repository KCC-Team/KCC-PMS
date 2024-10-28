$(document).ready(function () {
    getMainCount();
    getChartData();
    getProjectInfo();
});

function getMainCount() {
    $.ajax({
        url: '/projects/api/dashboard',
        type: 'GET',
        success: function(response) {
            $("#myTaskCount").text(response.TASK_COUNT);
            $("#myFeatCount").text(response.FEAT_COUNT);
            $("#myIssueCount").text(response.ISSUE_COUNT);
            $("#myDangerCount").text(response.DANGER_COUNT);
            $("#myDefectCount").text(response.DEFECT_COUNT);
            $("#task_count").text(response.TASK_COUNT);
            $("#prm_count").text(response.PROJECTMEMBER_COUNT);
            $("#pm_count").text(response.PM_COUNT);
            $("#pl_count").text(response.PL_COUNT);
            $("#normal_count").text(response.NORMAL_COUNT);

        },
        error: function(xhr, status, error) {
            console.log("Error:", error);
        }
    });
}

function getChartData() {
    $.ajax({
        url: '/projects/api/chart',
        type: 'GET',
        success: function(data) {
            console.log(data);

            let task_counts = [data.TASK_COUNT_01, data.TASK_COUNT_02, data.TASK_COUNT_03];
            taskStatusChart.data.datasets[0].data = task_counts;
            taskStatusChart.data.labels = [
                `대기(${data.TASK_COUNT_01})`,
                `진행중(${data.TASK_COUNT_02})`,
                `완료(${data.TASK_COUNT_03})`
            ];
            taskStatusChart.update();

           // let issue_counts = [data.ISSUE_COUNT_01, data.ISSUE_COUNT_02, data.ISSUE_COUNT_03, data.ISSUE_COUNT_04];
            let issue_counts = [1, 1, 1, 1];
            issueStatusChart.data.datasets[0].data = issue_counts;
            issueStatusChart.data.labels = [
                `발생전${data.ISSUE_COUNT_01})`,
                `진행중(${data.ISSUE_COUNT_02})`,
                `조치완료(${data.ISSUE_COUNT_03})`,
                `취소(${data.ISSUE_COUNT_04})`
            ];
            issueStatusChart.update();

            // let danger_counts = [data.DANGER_COUNT_01, data.DANGER_COUNT_02, data.DANGER_COUNT_03, data.DANGER_COUNT_04];
            let danger_counts = [1, 1, 1, 1];
            dangerStatusChart.data.datasets[0].data = danger_counts;
            dangerStatusChart.data.labels = [
                `발생전${data.DANGER_COUNT_01})`,
                `진행중(${data.DANGER_COUNT_02})`,
                `조치완료(${data.DANGER_COUNT_03})`,
                `취소(${data.DANGER_COUNT_04})`
            ];
            dangerStatusChart.update();

            let defect_counts = [data.DEFECT_COUNT_01, data.DEFECT_COUNT_02, data.DEFECT_COUNT_03, data.DEFECT_COUNT_04];
            defectsStatusChart.data.datasets[0].data = defect_counts;
            defectsStatusChart.data.labels = [
                `신규${data.DEFECT_COUNT_01})`,
                `해결(${data.DEFECT_COUNT_02})`,
                `조치완료(${data.DEFECT_COUNT_03})`,
                `취소(${data.DEFECT_COUNT_04})`
            ];
            defectsStatusChart.update();

        },
        error: function(xhr, status, error) {
            console.error('Error fetching data:', error);
        }
    });
}


function getProjectInfo() {
    $.ajax({
        url: '/projects/api/project',
        type: 'GET',
        success: function(response) {
            let prj_stat_cd = "완료";

            $('#prj_title').text(response.project.prj_title);
            if (response.project.stat_cd == 'PMS00101') {
                prj_stat_cd = '대기';
            } else if (response.project.stat_cd == 'PMS00102') {
                prj_stat_cd = '진행중';
            }
            $('#stat_cd').text(prj_stat_cd);
            response.project.prg = Math.round(response.project.prg / 10) * 10;
            $('#prg').text(response.project.prg + "%");
            $(".progress").css("width", response.project.prg + "%");
            $('#org').text(response.project.org);
            $('#st_dt').text(response.project.st_dt);
            $('#end_dt').text(response.project.end_dt);
        },
        error: function(xhr, status, error) {
            console.error('에러:', xhr.responseText);
        }
    });
}


// 작업 현황 차트
const taskStatusChartCtx = document.getElementById('taskStatusChart').getContext('2d');
const taskStatusChart = new Chart(taskStatusChartCtx, {
    type: 'doughnut',
    data: {
        labels: ['대기(0)', '진행중(0)', '완료(0)'],
        datasets: [{
            data: [0, 0, 0],
            backgroundColor: ['#FF6699', '#1abc9c', '#3498db'],
            borderColor: '#fff',
            borderWidth: 2
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                color: '#000',
                font: {
                    size: 16,
                    weight: 'bold'
                },
                formatter: (value) => {
                    return value;
                },
                anchor: 'center',
                align: 'center',
                clip: false
            }
        },
        legend: {
            display: true,
            position: 'top',
            labels: {
                boxWidth: 10
            }
        },
        layout: {
            padding: {
                top: 10
            }
        }
    }
});


// 이슈 현황 차트
const issueStatusChartCtx = document.getElementById('issueStatusChart').getContext('2d');
const issueStatusChart = new Chart(issueStatusChartCtx, {
    type: 'doughnut',
    data: {
        labels: ['발생전(0)', '진행중(0)', '조치완료(0)', '취소(0)'],
        datasets: [{
            data: [0, 0, 0, 0],
            backgroundColor: ['#FF6699', '#2ecc71', '#3498db', '#FFFF99'],
            borderColor: ['#FF6699', '#2ecc71', '#3498db', '#FFFF99'],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                color: '#000',
                font: {
                    size: 16,
                    weight: 'bold'
                },
                formatter: (value) => {
                    return value;
                },
                anchor: 'center',
                align: 'center',
                clip: false
            }
        },
        legend: {
            display: true,
            position: 'top',
            labels: {
                boxWidth: 10
            }
        },
        layout: {
            padding: {
                top: 10
            }
        }
    }
});


// 위험 현황 차트
const dangerStatusChartCtx = document.getElementById('dangerStatusChart').getContext('2d');
const dangerStatusChart = new Chart(dangerStatusChartCtx, {
    type: 'doughnut',
    data: {
        labels: ['발생전(0)', '진행중(0)', '조치완료(0)', '취소(0)'],
        datasets: [{
            data: [0, 0, 0, 0],
            backgroundColor: ['#FF6699', '#2ecc71', '#3498db', '#FFFF99'],
            borderColor: ['#FF6699', '#2ecc71', '#3498db', '#FFFF99'],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                color: '#000',
                font: {
                    size: 16,
                    weight: 'bold'
                },
                formatter: (value) => {
                    return value;
                },
                anchor: 'center',
                align: 'center',
                clip: false
            }
        },
        legend: {
            display: true,
            position: 'top',
            labels: {
                boxWidth: 10
            }
        },
        layout: {
            padding: {
                top: 10
            }
        }
    }
});


// 결함 현황 차트
const defectsStatusChartCtx = document.getElementById('defectsStatusChart').getContext('2d');
const defectsStatusChart = new Chart(defectsStatusChartCtx, {
    type: 'doughnut',
    data: {
        labels: ['신규(0)', '진행중(0)', '해결(0)', '취소(0)',],
        datasets: [{
            data: [0, 0, 0, 0],
            backgroundColor: ['#FF6699', '#2ecc71', '#3498db', '#FFFF99'],
            borderColor: ['#FF6699', '#2ecc71', '#3498db', '#FFFF99'],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                color: '#000',
                font: {
                    size: 16,
                    weight: 'bold'
                },
                formatter: (value) => {
                    return value;
                },
                anchor: 'center',
                align: 'center',
                clip: false
            }
        },
        legend: {
            display: true,
            position: 'top',
            labels: {
                boxWidth: 10
            }
        },
        layout: {
            padding: {
                top: 10
            }
        }
    }
});