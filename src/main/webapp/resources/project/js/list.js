var queryString = window.location.search;
var queryParams = new URLSearchParams(queryString);
var prj_title = queryParams.get('prj_title');
var stat_cd = queryParams.get('stat_cd');

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


$(document).on('click', '.project-link', function() {
    let prjNo = $(this).data('prj-no');
    let prjTitle = $(this).text();

    $.ajax({
        url: '/projects/dashboardInfo',
        type: 'GET',
        data: {
            prjNo: prjNo,
            prjTitle: prjTitle
        },
        success: function(response) {
            window.location.href = '/projects/dashboard';
        },
        error: function(xhr, status, error) {
            console.error('에러 발생:', xhr.responseText);
        }
    });
});
