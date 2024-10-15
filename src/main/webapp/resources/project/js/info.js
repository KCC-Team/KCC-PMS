var queryString = window.location.search;
var queryParams = new URLSearchParams(queryString);
var type = queryParams.get('type');

getStatusCode();
if (type === 'view') {
    getProjectResult();
    $('#type').val('view');
}

$(document).ready(function () {
    // 프로젝트 기간
    $('#no_days_period').click(function () {
        noPeriodCheck();
    });

    $('#pre_st_dt, #pre_end_dt').on('change', function () {
        calculateDaysBetween('pre');
    });

    $('#st_dt, #end_dt').on('change', function () {
        calculateDaysBetween();
    });

    $('#prj_title').on('input', function () {
        let maxByteLength = 200;
        let byteLength = limitByteLength($(this), maxByteLength);
        let targetId = $(this).attr('id');
    });

    $('#org').on('input', function () {
        let maxByteLength = 50;
        let byteLength = limitByteLength($(this), maxByteLength);
        let targetId = $(this).attr('id');
    });

    $('#prj_cont').on('input', function () {
        let maxByteLength = 1000;
        let byteLength = limitByteLength($(this), maxByteLength);
        $(".char-count").text(byteLength);
        let targetId = $(this).attr('id');
    });

    // 인원 검색
    $('.search-member-btn').click(function () {
        window.open(
            "/projects/addMember?type=project",
            "프로젝트인원등록",
            "width=1000, height=800, resizable=yes"
        );
    });


    // form 전송
    $('#project_form').on('submit', function (event) {
        event.preventDefault();

        if ($('#mem_num').val() == '') {
            alert('프로젝트 담당자를 선택해주세요.');
            return false;
        }

        // 프로젝트 등록
        if ($('#type').val() !== 'view') {
            $.ajax({
                url: '/projects/api/project',
                type: 'POST',
                data: $(this).serialize(),
                success: function (response) {
                    alert('프로젝트가 등록되었습니다.');
                    location.href = "/projects/list";
                },
                error: function (xhr, status, error) {
                    console.error('에러:', xhr.responseText);
                    alert('저장 중 에러가 발생했습니다. 다시 시도해 주세요.');
                    return false;
                }
            });
        }

        // 프로젝트 수정
        if ($('#type').val() == 'view') {
            $.ajax({
                url: '/projects/api/project',
                type: 'Patch',
                data: $('#project_form').serialize(),
                success: function(response) {
                    alert('프로젝트가 수정되었습니다.');
                },
                error: function(xhr, status, error) {
                    console.error('에러:', xhr.responseText);
                    alert('수정 중 에러가 발생했습니다. 다시 시도해 주세요.');
                    return false;
                }
            });
        }
    });

});


// 데이터 조회
function getProjectResult() {
    $.ajax({
        url: '/projects/api/project',
        type: 'GET',
        success: function(response) {
            $('#prj_no').val(response.project.prj_no);
            $('#prj_title').val(response.project.prj_title);
            $('#stat_cd').val(response.project.stat_cd);
            $('#prg').val(response.project.prg);
            $('#org').val(response.project.org);
            $('#pre_st_dt').val(response.project.pre_st_dt);
            $('#pre_end_dt').val(response.project.pre_end_dt);
            $('#st_dt').val(response.project.st_dt);
            $('#end_dt').val(response.project.end_dt);
            $('#mem_no').val(response.projectManager.memNo);
            $('#mem_num').val(response.projectManager.memNm);
            $('#prj_cont').val(response.project.prj_cont);

            if (response.project.st_dt == null || response.project.st_dt == '') {
                $("#no_days_period").prop('checked', true);
                $("#st_dt").attr("readonly", true).val('').css("background-color", "#e9ecef");
                $("#end_dt").attr("readonly", true).val('').css("background-color", "#e9ecef");
            }
            $(".char-count").text($("#prj_cont").val().length);
        },
        error: function(xhr, status, error) {
            console.error('에러:', xhr.responseText);
        }
    });
}


// 상태 코드 호출
function getStatusCode() {
    $.ajax({
        url: '/getCommonCodeList',
        type: 'GET',
        data: {commonCodeNo: 'PMS001'},
        success: function (response) {
            $('#stat_cd').find('option').not(':first').remove();
            $.each(response, function (index, item) {
                $('#stat_cd').append($('<option>', {
                    value: item.codeDetailNo,
                    text: item.codeDetailName
                }));
            });
        },
        error: function (error) {
            console.error(error);
        }
    });
}


function noPeriodCheck() {
    let checked = $('#no_days_period').is(':checked');
    if (checked) {
        $("#st_dt").attr("readonly", true).val('').css("background-color", "#e9ecef");
        $("#end_dt").attr("readonly", true).val('').css("background-color", "#e9ecef");
    } else {
        $("#st_dt").removeAttr("readonly").css("background-color", "");
        $("#end_dt").removeAttr("readonly").css("background-color", "");
    }
}


function handleStatusChange() {
    const statCd = document.getElementById('stat_cd').value;
    const prg = document.getElementById('prg');

    if (statCd === 'PMS00101') {
        prg.value = '0';
    }
    if (statCd === 'PMS00103') {
        prg.value = '100';
    }
}


// 날짜 계산
function calculateDaysBetween(division) {
    let sDate = '#st_dt';
    let eDate = '#end_dt';
    let days = '.days';

    if (division === 'pre') {
        sDate = '#pre_st_dt';
        eDate = '#pre_end_dt';
        days = '.pre_days';
    }

    let startDate = new Date($(sDate).val());
    let endDate = new Date($(eDate).val());

    // Ensure both dates are selected
    if (!isNaN(startDate) && !isNaN(endDate)) {
        let timeDifference = endDate.getTime() - startDate.getTime();
        let dayDifference = timeDifference / (1000 * 3600 * 24);

        // Update the days span
        $(days).text(`(${dayDifference}일)`);
    } else {
        $(days).text('(0일)');
    }
}


// 현재 날짜를 YYYY-MM-DD 형식으로 변환하는 함수
function getCurrentDate() {
    let today = new Date();
    let year = today.getFullYear();
    let month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
    let day = ('0' + today.getDate()).slice(-2);
    return year + '-' + month + '-' + day;
}


// 바이트 수 제한하는 함수
function limitByteLength(input, maxByteLength) {
    var text = input.val();
    var byteLength = 0;
    var newText = '';

    for (var i = 0; i < text.length; i++) {
        var char = text.charAt(i);
        // 한글 또는 특수문자는 3바이트
        if (escape(char).length > 4) {
            byteLength += 3;
        } else {
            // 영어, 숫자, 기호는 1바이트
            byteLength += 1;
        }

        if (byteLength > maxByteLength) {
            break; // 최대 바이트를 초과하면 반복 중단
        }
        newText += char; // 허용되는 범위 내의 문자만 추가
    }

    // 입력 값을 허용된 범위로 잘라내기
    input.val(newText);

    return byteLength;
}


// 팝업 데이터 연결
window.addEventListener('message', function (event) {
    if (event.origin !== "http://localhost:8085") {
        return;
    }

    let addedMembers = event.data;
    // 멤버 이름과 ID 설정
    document.getElementById("mem_num").value = addedMembers[0].name;
    document.getElementById("mem_no").value = addedMembers[0].id;
    // 권한 코드 설정
    if (addedMembers[0].auth != '') {
        document.getElementById('prj_auth_cd').value = addedMembers[0].auth;
    } else {
        document.getElementById('prj_auth_cd').value = 'PMS00201';
    }
    // 예비 시작일 설정
    if (addedMembers[0].pre_st_dt != '') {
        document.getElementById('pm_pre_start_dt').value = addedMembers[0].pre_st_dt;
    }
    // 예비 종료일 설정
    if (addedMembers[0].pre_end_dt != '') {
        document.getElementById('pm_pre_end_dt').value = addedMembers[0].pre_end_dt;
    }
    // 시작일 설정
    if (addedMembers[0].st_dt != '') {
        document.getElementById('pm_start_dt').value = addedMembers[0].st_dt;
    }
    // 종료일 설정
    if (addedMembers[0].end_dt != '') {
        document.getElementById('pm_end_dt').value = addedMembers[0].end_dt;
    }
});


function validateDate(startDateElem, endDateElem) {
    const startDate = new Date(startDateElem.value);
    const endDate = new Date(endDateElem.value);

    if (endDateElem.value && endDate < startDate) {
        alert("종료일은 시작일보다 이전일 수 없습니다.");
        endDateElem.value = ""; // 종료일을 비움
    }
}

// 프로젝트 예정기간 (pre_st_dt, pre_end_dt)
const preStartDate = document.getElementById("pre_st_dt");
const preEndDate = document.getElementById("pre_end_dt");

preStartDate.addEventListener("change", () => validateDate(preStartDate, preEndDate));
preEndDate.addEventListener("change", () => validateDate(preStartDate, preEndDate));

// 프로젝트 실제기간(st_dt, end_dt)
const startDate = document.getElementById("st_dt");
const endDate = document.getElementById("end_dt");
const noDaysPeriodCheckbox = document.getElementById("no_days_period");

startDate.addEventListener("change", () => validateDate(startDate, endDate));
endDate.addEventListener("change", () => validateDate(startDate, endDate));