// 작업 현황 차트
const taskStatusChartCtx = document.getElementById('taskStatusChart').getContext('2d');
const taskStatusChart = new Chart(taskStatusChartCtx, {
    type: 'doughnut',
    data: {
        labels: ['진행(1)', '미진행(1)', '완료(10)'],
        datasets: [{
            data: [1, 1, 10],
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

function updateChartData() {
    $.ajax({
        url: '/data-page',
        method: 'POST',
        dataType: 'json',
        success: function(data) {
            const counts = data.counts;

            taskStatusChart.data.datasets[0].data = counts;
            taskStatusChart.data.labels = [
                `진행(${counts[0]})`,
                `미진행(${counts[1]})`,
                `완료(${counts[2]})`
            ];

            taskStatusChart.update();
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data:', error);
        }
    });
}


// 이슈 현황 차트
const issueStatusChartCtx = document.getElementById('issueStatusChart').getContext('2d');
const issueStatusChart = new Chart(issueStatusChartCtx, {
    type: 'doughnut',
    data: {
        labels: ['신규(2)', '진행중(2)', '조치완료(3)'],
        datasets: [{
            data: [2, 2, 3],
            backgroundColor: ['#FF6699', '#2ecc71', '#3498db'],
            borderColor: ['#FF6699', '#2ecc71', '#3498db'],
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
        labels: ['신규(3)', '진행중(4)', '조치완료(3)'],
        datasets: [{
            data: [3, 4, 3],
            backgroundColor: ['#FF6699', '#2ecc71', '#3498db'],
            borderColor: ['#FF6699', '#2ecc71', '#3498db'],
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
        labels: ['신규(1)', '진행중(4)', '조치완료(3)'],
        datasets: [{
            data: [1, 4, 3],
            backgroundColor: ['#FF6699', '#2ecc71', '#3498db'],
            borderColor: ['#FF6699', '#2ecc71', '#3498db'],
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