getStatusCode();

// 상태 코드 호출
function getStatusCode() {
    $.ajax({
        url: '/getCommonCodeList',
        type: 'GET',
        data: {commonCodeNo : 'PMS001'},
        success: function(response) {
            $('#stat_cd').find('option').not(':first').remove();
            $.each(response, function(index, item) {
                $('#stat_cd').append($('<option>', {
                    value: item.codeDetailNo,
                    text: item.codeDetailName
                }));
            });
        },
        error: function(error) {
            console.error(error);
        }
    });
}