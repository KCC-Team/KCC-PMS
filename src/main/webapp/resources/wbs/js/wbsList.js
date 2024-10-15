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

gantt.config.date_format = "%Y-%m-%d";  // 날짜 형식을 명시적으로 설정
gantt.config.date_scale = "%d";  // 날짜 형식 설정
gantt.config.subscales = [{unit: "month", step: 1, date: "%Y-%m"}];  // 월 단위 보조 스케일


// Gantt 그리드 설정
gantt.config.columns = [
    {name: "id", label: "순번", width: 40, resize: true},
    {name: "text", label: "작업명", width: 200, tree: true, resize: true},
    {name: "tsk_stat_cd", label: "상태", width: 45, resize: true},
    {name: "pre_st_dt", label: "예정 시작일", align: "center", width: 80, resize: true},
    {name: "pre_end_dt", label: "예정 종료일", align: "center", width: 80, resize: true},
    {name: "start_date", label: "시작일", align: "center", width: 80, resize: true},
    {name: "end_date", label: "종료일", align: "center", width: 80, resize: true},
    {name: "progress", label: "진척도", align: "center", width: 60, template: function(task) { return task.progress * 100 + "%"; }, resize: true},
    // {name: "weight_val", label: "가중치", align: "center", width: 70, template: function(task) { return task.weight_val || ""; }, resize: true},
    {name: "ante_task_no", label: "선행작업", align: "center", width: 47, template: function(task) { return task.ante_task_no || ""; }, resize: true},
    {name: "manager", label: "담당자", align: "center", width: 90, template: function(task) { return task.manager || ""; }, resize: true},
    {name: "addbtn", label: "", width: 30, align: "center", template:
            function(task) {
                return "<button class='add-wbs'><i class=\"fa-regular fa-square-plus\"></i></button>";
            }
    }
];

// // Lightbox에 표시할 필드 설정
// gantt.config.lightbox.sections = [
//     {name: "text", height: 35, map_to: "text", type: "textarea", focus: true, label: "작업명"},  // "text" 필드와 매핑
//     {name: "tsk_stat_cd", height: 35, map_to: "tsk_stat_cd", type: "select", options: [
//         {key: "001", label: "발생전"},
//         {key: "002", label: "진행중"},
//         {key: "003", label: "조치완료"},
//         {key: "004", label: "취소"}
//     ], label: "상태"},
//     {name: "par_task_no", height: 30, map_to: "par_task_no", type: "textarea", label: "상위작업"},
//     //  {name: "pre_st_dt", height: 38, map_to: "pre_st_dt", type: "date", label: "예정 시작일"},
//     //  {name: "pre_end_dt", height: 38, map_to: "pre_end_dt", type: "date", label: "예정 종료일"},
//     //  {name: "start_date", height: 38, map_to: "start_date", type: "date", label: "시작일"},
//     //  {name: "end_date", height: 38, map_to: "end_date", type: "date", label: "종료일"},
//     {name: "pre_st_dt", type: "duration", map_to: "pre_st_dt", label: "기간22"},
//     {name: "pre_end_dt", type: "duration", map_to: "pre_end_dt", label: "기간33"},
//     {name: "start_date", type: "date",  map_to: "start_date", label: "기간",},
//     {name: "end_date", type: "date", map_to: "end_date", label: "기간1"},
//     {name: "system", height: 38, map_to: "system", type: "textarea", label: "시스템/업무"},
//     {name: "progress", height: 38, map_to: "progress", type: "textarea", label: "진척도"},
//     {name: "weight_val", height: 38, map_to: "weight_val", type: "textarea", label: "가중치"},
//     {name: "manager", height: 38, map_to: "manager", type: "textarea", label: "담당자"},
//     {name: "rel_out_nm", height: 38, map_to: "rel_out_nm", type: "textarea", label: "관련 산출물"},
//     {name: "ante_task_no", height: 38, map_to: "ante_task_no", type: "textarea", label: "선행 작업"}
// ];

// 샘플 데이터
var tasks = {
    data: [
        {id: "1", text: "A업무시스템", pre_st_dt: "2024-02-01", pre_end_dt: "2024-02-28", start_date: "2024-02-28", end_date: "2024-03-03", progress: 0.5, ante_task_no: "", tsk_stat_cd: "진행중", sys_no: "시스템 A", weight_val: 2, manager: "김철수", rel_out_nm: "문서 A", par_task_no: "부모1 > 자식"},  // 부모 작업
        {parent: "1", id: "2", text: "A업무시스템 작업1", pre_st_dt: "2024-02-01", pre_end_dt: "2024-02-28", start_date: "2024-02-28", end_date: "2024-03-05", progress: 0.5, ante_task_no: "1", tsk_stat_cd: "진행중", sys_no: "시스템 A", weight_val: 2, manager: "김철수", rel_out_nm: "문서 A", par_task_no: "부모1 > 자식"},  // 부모 작업
        {parent: "1", id: "3", text: "A업무시스템 작업2", pre_st_dt: "2024-06-01", pre_end_dt: "2024-06-28", start_date: "2024-06-01", end_date: "2024-06-28", progress: 0.5, ante_task_no: "1.1", tsk_stat_cd: "진행중", sys_no: "시스템 A", weight_val: 2, manager: "김철수", rel_out_nm: "문서 A", par_task_no: "부모1 > 자식"},  // 부모 작업
        {id: "2", text: "B업무시스템", pre_st_dt: "2024-02-01", pre_end_dt: "2024-02-28", start_date: "2024-02-28", end_date: "2024-03-05", progress: 0.5, ante_task_no: "1", tsk_stat_cd: "진행중", sys_no: "시스템 A", weight_val: 2, manager: "김철수", rel_out_nm: "문서 A", par_task_no: "부모1 > 자식"},  // 부모 작업
        {parent: "2", id: "1", text: "A업무시스템 작업2", pre_st_dt: "2024-06-01", pre_end_dt: "2024-06-28", start_date: "2024-06-01", end_date: "2024-06-28", progress: 0.5, ante_task_no: "1.1", tsk_stat_cd: "진행중", sys_no: "시스템 A", weight_val: 2, manager: "김철수", rel_out_nm: "문서 A", par_task_no: "부모1 > 자식"},  // 부모 작업
    ]
};

// 순번 커스텀
for (var i = 0; i < tasks.data.length; i++) {
    var task = tasks.data[i];
    if (task.parent) {
        task.id = task.parent + "." + task.id;
    }
}


// 작업 간의 드래그 앤 드롭을 통해 순서 변경
gantt.config.order_branch = false;  // 부모 작업 내에서 순서 변경(기본값:false)
gantt.config.order_branch_free = false;  // 작업을 다른 부모 작업으로 드래그 가능(기본값:false)
gantt.config.drag_resize_columns = true;

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

// 작업 저장 시 호출되는 이벤트 (Lightbox에서 저장될 때)
gantt.attachEvent("onLightboxSave", function(id, task, is_new) {

    // console.log(task);
    // var taskId = gantt.addTask({
    //     id: 3,
    //     parent: 2,
    //     text: "Task #3",
    //     start_date: "2024-02-28",
    //     end_date: "2024-03-02",
    //     progress : 0.1
    // });
    // gantt.updateTask(taskId); // 작업 업데이트
    // logCurrentTasks();


    if (!isTaskAdding) {
        isTaskAdding = true;
        gantt.updateTask(id);  // 작업 업데이트
        logCurrentTasks();
        isTaskAdding = false;
    }
    return true;
});

// 작업이 추가된 후 실행되는 이벤트
gantt.attachEvent("onAfterTaskAdd", function(id, item) {
    if (!isTaskAdding) {
        isTaskAdding = true;
        logCurrentTasks();  // 작업 상태를 로그로 기록
        isTaskAdding = false;
    }
});

// 작업이 업데이트된 후 실행되는 이벤트
gantt.attachEvent("onAfterTaskUpdate", function(id, item) {
    logCurrentTasks();  // 작업 상태를 로그로 기록
});

// 작업이 삭제된 후 실행되는 이벤트
gantt.attachEvent("onAfterTaskDelete", function(id) {
    logCurrentTasks();  // 작업 삭제 후 로그 기록
});

// 로그 기능 (변경 사항 추적)
gantt.attachEvent("onAfterTaskMove", function(id, parent, tindex){
    console.log("작업 ID " + id + "이(가) 새로운 위치로 이동됨.");
    console.log("새 부모 ID: " + parent + ", 새로운 인덱스: " + tindex);
});


gantt.init("gantt_here");  // Gantt 차트 초기화
gantt.parse(tasks);  // 작업 데이터 로드


gantt.eachTask(function(task) {
    gantt.open(task.id);  // 각 작업의 트리를 확장
});

// 변경 사항 확인
function logCurrentTasks() {
    var currentTasks = gantt.serialize();
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

// Gantt가 렌더링된 후 열 크기 조정 기능 활성화
gantt.attachEvent("onGanttRender", function() {
    makeResizableColumns();
});


$(document).on("click", ".add-wbs", function() {
    // 순번
    let tsk_num = $(this).parent().parent().parent().find('.gantt_tree_content:eq(0)').text();

    window.open(
        "/projects/wbsInfo?tsk_num=" + tsk_num,
        "프로젝트WBS",
        "width=970, height=450, resizable=yes"
    );
});


$(document).ready(function() {
    $('.btn-modify-wbs').click(function() {
        $('.btn-save-wbs-sort').show();
        $('.btn-modify-wbs').hide();
        gantt.config.order_branch = true;  // 부모 작업 내에서 순서 변경 가능
        gantt.config.order_branch_free = true;  // 작업을 다른 부모 작업으로 드래그 가능
        gantt.init("gantt_here");  // Gantt 차트 초기화
    });

    $('.btn-save-wbs-sort').click(function() {
        $('.btn-modify-wbs').show();
        $('.btn-save-wbs-sort').hide();
        gantt.config.order_branch = false;  // 부모 작업 내에서 순서 변경 가능
        gantt.config.order_branch_free = false;  // 작업을 다른 부모 작업으로 드래그 가능
        gantt.init("gantt_here");  // Gantt 차트 초기화
    });

    // 그리드 숨김 상태를 추적할 변수
    var gridHidden = false;
    // 토글 버튼 클릭 시 이벤트 처리
    document.getElementById("toggle-grid").addEventListener("click", function() {
        var ganttContainer = document.getElementById("gantt_here");

        if (!gridHidden) {
            // 그리드를 숨기고 타임라인을 크게 표시
            ganttContainer.classList.add("grid_hidden");
            document.getElementById("toggle-grid").innerText = "기본 화면으로 보기";
        } else {
            // 그리드를 다시 표시하고 기본 상태로 복원
            ganttContainer.classList.remove("grid_hidden");
            document.getElementById("toggle-grid").innerText = "간트 차트 크게 보기";
        }
        gridHidden = !gridHidden;
    });

});