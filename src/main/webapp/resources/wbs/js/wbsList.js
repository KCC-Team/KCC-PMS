// 한글 번역 설정
gantt.locale = {
    labels: {
    },
    date: {
        month_full: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        month_short: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        day_full: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
        day_short: ["일", "월", "화", "수", "목", "금", "토"]
    }
};

gantt.config.row_height = 40;
gantt.config.scale_height = 40;
gantt.config.date_format = "%Y-%m-%d %H:%i";  // 시간까지 포함한 형식으로 설정
gantt.config.date_scale = "%d";  // 날짜 형식 설정
gantt.config.subscales = [{unit: "month", step: 1, date: "%Y-%m"}];  // 월 단위 보조 스케일

// Gantt 그리드 설정
gantt.config.columns = [
    {name: "id", label: "순번", align: "left", width: 40, resize: true, template: function (task) {
        if (String(task.id).includes("0")) {
            let taskId = String(task.id).replace(/0/g, "."); // 모든 "0"을 "."으로 변경
            return taskId;
        }
        return task.id;
    }},
    {name: "text", label: "작업명", align: "left", width: 180, tree: true, resize: true},
    {name: "tsk_stat_cd", label: "상태", width: 45, align: "center", resize: true},
    {name: "start_date", label: "예정 시작일", align: "center", width: 80, resize: true},
    {name: "end_date", label: "예정 종료일", align: "center", width: 80, resize: true},
    {name: "real_st_dt", label: "시작일", align: "center", width: 80, resize: true},
    {name: "real_end_dt", label: "종료일", align: "center", width: 80, resize: true},
    {name: "progress", label: "진척도", align: "center", width: 60, template: function(task) { return task.progress * 100 + "%"; }, resize: true},
    // {name: "weight_val", label: "가중치", align: "center", width: 70, template: function(task) { return task.weight_val || ""; }, resize: true},
    // {name: "ante_task_no", label: "선행작업", align: "center", width: 47, template: function(task) { return task.ante_task_no || ""; }, resize: true},
    {name: "manager", label: "담당자", align: "center", width: 90, template: function(task) { return task.manager || ""; }, resize: true},
    // {name: "addbtn", label: "", width: 30, align: "center", template:
    //         function(task) {
    //             return "<button class='add-wbs'><i class=\"fa-regular fa-square-plus\"></i></button>";
    //         }
    // }
];


if (prjNo != undefined) {
    getProjectResult();
}

// 데이터 조회
function getProjectResult() {
    $.ajax({
        url: '/projects/api/wbs',
        type: 'GET',
        success: function(response) {

            let tasks = {
                data: [] // 빈 배열로 초기화
            };

            response.forEach(function(item) {
                let endDate = new Date(item.pre_end_dt);
                endDate.setHours(23, 59, 59, 999);
                let newEndDate = gantt.date.date_to_str("%Y-%m-%d %H:%i")(endDate);

                tasks.data.push({
                    parent: item.par_task_no,
                    id: item.tsk_no,
                    text: item.tsk_ttl,
                    start_date: item.pre_st_dt,
                    end_date: newEndDate,
                    real_st_dt: item.st_dt || "-",
                    real_end_dt: item.end_dt || "-",
                    progress: item.prg / 100,
                    ante_task_no: item.ante_task_no,
                    tsk_stat_cd: item.wbs_status,
                    weight_val: item.weight_val,
                    manager: item.members,
                    rel_out_nm: item.rel_out_nm,
                    par_task_no: item.par_task_no
                });
            });

            // 작업 간의 드래그 앤 드롭을 통해 순서 변경
            gantt.config.order_branch = false;  // 부모 작업 내에서 순서 변경(기본값:false)
            gantt.config.order_branch_free = false;  // 작업을 다른 부모 작업으로 드래그 가능(기본값:false)
            gantt.config.drag_resize_columns = true;

            gantt.config.scroll_size = 20;  // 스크롤바 크기 설정
            gantt.config.min_column_width = 70;  // 최소 열 너비 설정
            gantt.config.grid_width = 400;  // 그리드 너비 설정
            gantt.config.autosize = false;  // 자동 크기 비활성화
            gantt.config.fit_tasks = false;  // 작업을 화면 너비에 맞추지 않도록 설정


            gantt.init("gantt_here");  // Gantt 차트 초기화
            gantt.parse(tasks);  // 작업 데이터 로드
            gantt.render();


            if (tasks.data.length > 0) {
                $('.add-save-wbs').hide();
                $('#gantt_no_data').hide();
                $('#gantt_here').show();
                $('.btn-modify-wbs').show();
                $('#toggle-grid').show();
            } else {
                $('.add-save-wbs').show();
                $('#gantt_no_data').show();
                $('#gantt_here').hide();
                $('.btn-modify-wbs').hide();
                $('#toggle-grid').hide();
            }

            gantt.eachTask(function(task) {
                gantt.open(task.id);  // 각 작업의 트리를 확장
            });

        },
        error: function(xhr, status, error) {
            console.error('에러:', xhr.responseText);
        }
    });
}



// 작업이 추가될 때 중복 호출 방지
let isTaskAdding = false;

// 기존 Lightbox가 열리지 않도록 설정
gantt.showLightbox = function(id) {
    return false;
};

// 타임라인에서 작업 드래그 방지
gantt.attachEvent("onBeforeTaskDrag", function(id, mode, e) {
    return false; // 드래그를 방지
});

// // 작업 저장 시 호출되는 이벤트 (Lightbox에서 저장될 때)
// gantt.attachEvent("onLightboxSave", function(id, task, is_new) {
//
//     // console.log(task);
//     // let taskId = gantt.addTask({
//     //     id: 3,
//     //     parent: 2,
//     //     text: "Task #3",
//     //     start_date: "2024-02-28",
//     //     end_date: "2024-03-02",
//     //     progress : 0.1
//     // });
//     // gantt.updateTask(taskId); // 작업 업데이트
//     // logCurrentTasks();
//
//
//     if (!isTaskAdding) {
//         isTaskAdding = true;
//         gantt.updateTask(id);  // 작업 업데이트
//         logCurrentTasks();
//         isTaskAdding = false;
//     }
//     return true;
// });
//
// // 작업이 추가된 후 실행되는 이벤트
// gantt.attachEvent("onAfterTaskAdd", function(id, item) {
//     if (!isTaskAdding) {
//         isTaskAdding = true;
//         logCurrentTasks();  // 작업 상태를 로그로 기록
//         isTaskAdding = false;
//     }
// });
//
// // 작업이 업데이트된 후 실행되는 이벤트
// gantt.attachEvent("onAfterTaskUpdate", function(id, item) {
//     logCurrentTasks();  // 작업 상태를 로그로 기록
// });
//
// // 작업이 삭제된 후 실행되는 이벤트
// gantt.attachEvent("onAfterTaskDelete", function(id) {
//     logCurrentTasks();  // 작업 삭제 후 로그 기록
// });


// 로그 기능 (변경 사항 추적)
gantt.attachEvent("onAfterTaskMove", function(id, parent, tindex){
    console.log("작업 ID " + id + "이(가) 새로운 위치로 이동됨.");
    console.log("새 부모 ID: " + parent + ", 새로운 인덱스: " + tindex);
    $.ajax({
        url: '/projects/wbs/updateOrder',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            wbsNo: id,
            newParentNo: parent,
            newPosition: tindex
        }),
        success: function(response) {
            console.log('노드 순서가 성공적으로 반영되었습니다.');
        },
        error: function(xhr, status, error) {
            console.error('노드 순서 변경에 실패했습니다: ', error);
        }
    });
});

// Gantt가 렌더링된 후 열 크기 조정 기능 활성화
gantt.attachEvent("onGanttRender", function() {
    makeResizableColumns();
});

// onContextMenu 이벤트 핸들러
gantt.attachEvent("onContextMenu", function (id, linkId, e) {
    // 기본 우클릭 메뉴 제거
    e.preventDefault();
    removeContextMenu();
    console.log("taskNo = " + id);
    if (!id) {
        return true;
    }

    // 우클릭한 작업의 정보 가져오기
    let task = gantt.getTask(id);

    console.log(task.id);

    // 부모 작업 ID 가져오기 (최상위 작업일 경우 부모가 없을 수 있음)
    let parentTaskId = task.parent ? task.parent : "null";  // 부모가 없는 경우 '없음' 표시

    // 부모 작업이 있는 경우 형제 요소들을 구함
    let lastSiblingId = id;  // 마지막 형제 작업의 ID
    if (parentTaskId) {
        // 부모 작업의 모든 자식 작업(형제들) 가져오기
        let childrenOfParent = gantt.getChildren(parentTaskId);

        // 현재 작업을 제외한 형제 작업들만 필터링
        let siblings = childrenOfParent.filter(function(childId) {
            return childId !== id;  // 현재 작업을 제외
        });

        // 형제 작업 중 마지막 작업의 ID 가져오기
        if (siblings.length > 0) {
            lastSiblingId = siblings[siblings.length - 1];  // 배열의 마지막 요소
        }
    }

    if (lastSiblingId) {
        let lastSiblingTask = gantt.getTask(lastSiblingId);
        lastSiblingId = lastSiblingTask.id;
    }

    //아래에추가 => 클릭한친구의 부모아이디
    //하위에추가 => 클릭한친구의 아이디


    // 자식 작업들 가져오기
    let children = gantt.getChildren(id);

    // 마지막 자식 ID 가져오기
    let lastChildId = children.length > 0 ? children[children.length - 1] : "0";

    let additionalButton = '';
    if (id.length < 5) {
        additionalButton = `<input type=button value="하위로 추가" class="btn-task" onclick="wbsInfoPopup('child', ${lastChildId}, ${id}, ${task.id})"><br/>`;
    }

    // 커스텀 메뉴 생성
    const contextMenu = `
    <div
        style="position: absolute; top: ${e.clientY}px; left: ${e.clientX}px; background: white; border: 1px solid #ccc; padding: 10px;"
        class='context_menu'
        "
    >
      <input type=button value="아래에 추가" class="btn-task" onclick="wbsInfoPopup('new', ${lastSiblingId}, ${parentTaskId}, ${task.par_task_no})">
      <br/>
      ${additionalButton}
      <input type=button value="상세 정보" class="btn-task" onclick="wbsInfoPopup('view', ${id}, ${id})">
    </div>
    `;

    // 메뉴를 DOM에 추가
    const el = document.createElement("div");
    el.innerHTML = contextMenu;
    document.body.appendChild(el);

    return false;  // 기본 동작 방지
});


// 우클릭 메뉴 제거 함수
function removeContextMenu() {
    const menu = document.querySelector('.context_menu');
    if (menu) {
        menu.remove();
    }
}

// 문서 클릭 시 메뉴 제거
document.addEventListener("click", removeContextMenu);


// 변경 사항 확인
function logCurrentTasks() {
    let currentTasks = gantt.serialize();
    console.log(JSON.stringify(currentTasks, null, 2));
}


// 열 크기 조정 기능 구현
function makeResizableColumns() {
    const headers = document.querySelectorAll(".gantt_grid_head_cell");
    headers.forEach((header, index) => {
        $(header).resizable({
            handles: "e",
            resize: function(event, ui) {
                const newWidth = ui.size.width;
                header.style.width = newWidth + "px";

                // Gantt에서 같은 열의 데이터 셀에도 동일한 너비 적용
                const columnIndex = $(header).index();
                document.querySelectorAll(".gantt_row .gantt_cell:nth-child(" + (columnIndex + 1) + ")").forEach((cell) => {
                    cell.style.width = newWidth + "px";
                });
            }
        });
    });
}


function wbsInfoPopup(type, id, parentId, max_order_id) {
    let url = "/projects/wbsInfo?page=wbs&type=" + type;
    if (id != undefined)  {
        url += "&id=" + id;
    }
    if (parentId != undefined)  {
        url += "&parentId=" + parentId;
    } if(max_order_id != undefined) {
        url += "&maxOrderId=" + max_order_id;
    }
    window.open(
        url,
        "프로젝트WBS",
        "width=960, height=480, resizable=yes"
    );
}


$(document).ready(function() {
    $('.btn-modify-wbs').click(function () {
        $('.btn-save-wbs-sort').show();
        $('.btn-modify-wbs').hide();
        gantt.config.order_branch = true;  // 부모 작업 내에서 순서 변경 가능
        gantt.config.order_branch_free = true;  // 작업을 다른 부모 작업으로 드래그 가능
        gantt.init("gantt_here");  // Gantt 차트 초기화
    });

    $('.btn-save-wbs-sort').click(function () {
        $('.btn-modify-wbs').show();
        $('.btn-save-wbs-sort').hide();
        gantt.config.order_branch = false;  // 부모 작업 내에서 순서 변경 가능
        gantt.config.order_branch_free = false;  // 작업을 다른 부모 작업으로 드래그 가능
        gantt.init("gantt_here");  // Gantt 차트 초기화
    });

    // 그리드 숨김 상태를 추적할 변수
    let gridHidden = false;
    // 토글 버튼 클릭 시 이벤트 처리
    document.getElementById("toggle-grid").addEventListener("click", function () {
        let ganttContainer = document.getElementById("gantt_here");

        if (!gridHidden) {
            gantt.config.grid_width = 0;
            ganttContainer.classList.add("grid_hidden");
            document.getElementById("toggle-grid").innerText = "기본 화면으로 보기";
            $(".btn-modify-wbs").hide();
        } else {
            gantt.config.grid_width = 730;
            ganttContainer.classList.remove("grid_hidden");
            document.getElementById("toggle-grid").innerText = "간트 차트 크게 보기";
            $(".btn-modify-wbs").show();
        }
        gridHidden = !gridHidden;
    });

});
