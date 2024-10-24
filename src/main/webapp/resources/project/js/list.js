let queryString = window.location.search;
let queryParams = new URLSearchParams(queryString);
let prj_title = queryParams.get('prj_title');
let stat_cd = queryParams.get('stat_cd');
let type = queryParams.get('type');

if (type == 'projectList') {
    getRecentProjectInfo();
}
getStatusCode();

// 상태 코드 호출
function getStatusCode() {
    $.ajax({
        url: '/getCommonCodeList',
        type: 'GET',
        data: {commonCodeNo : 'PMS001'},
        success: function(response) {
            $('#stat_cd').find('option').not(':first').remove();
            $('#stat_cd').append( $('<option value="all">전체</option>')  );
            $.each(response, function(index, item) {
                $('#stat_cd').append($('<option>', {
                    value: item.codeDetailNo,
                    text: item.codeDetailName
                }));
            });
            if (stat_cd == null || stat_cd == '') {
                $("#stat_cd").val('all');
            } else {
                $("#stat_cd").val(stat_cd);
            }
        },
        error: function(error) {
            console.error(error);
        }
    });
}

function getRecentProjectInfo() {
    $.ajax({
        url: '/projects/api/project/recentProjectInfo',
        type: 'GET',
        success: function(response) {
            console.log(response);
            connectDashboard(response.recPrj, response.prjTitle);
        },
        error: function(error) {
            console.error(error);
        }
    });
}


$(document).ready(function () {

    let actionForm = $("#actionForm");
    $(".paginate_button a").on("click",function(e) {
        e.preventDefault();
        actionForm.find( "input[name='pageNum']").val($(this).attr("href") );

        if (prj_title != null && prj_title != '') {
            actionForm.find( "input[name='prj_title']").val(prj_title);
        }
        if (stat_cd == null || stat_cd == '') {
            actionForm.find( "input[name='stat_cd']").val('all');
        }
        if (stat_cd != null && stat_cd != '') {
            actionForm.find( "input[name='stat_cd']").val(stat_cd);
        }

        actionForm.attr("action","/projects/list");

        actionForm.submit();
    });
});

function connectDashboard(prjNo, prjTitle) {
    $.ajax({
        url: '/projects/dashboardInfo',
        type: 'GET',
        data: {
            prjNo: prjNo,
            prjTitle: prjTitle
        },
        success: function(response) {
            window.location.replace('/projects/dashboard');
        },
        error: function(xhr, status, error) {
            console.error('에러 발생:', xhr.responseText);
        }
    });
}


$(document).on('click', '.project-link', function() {
    let prjNo = $(this).data('prj-no');
    let prjTitle = $(this).text();
    connectDashboard(prjNo, prjTitle);
});
