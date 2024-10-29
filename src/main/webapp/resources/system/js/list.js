$(document).ready(function () {
    getSystemList();

    setTimeout(function() {
        let thirdTd = $('.system-table td').eq(2);
        if (thirdTd.length) {
            thirdTd.trigger('click');
        }
    }, 100);

    $('.system-table').on('click', 'td', function() {
        if ($(this).attr("id") != null) {
            $('.system-table td').removeClass('active'); // 모든 td에서 active 클래스 제거
            $(this).addClass('active'); // 클릭한 td에만 active 클래스 추가

            let find_title = $(this).children(".title").text();
            let find_desc = $(this).children(".system-dis").text();

            $(".system-info").text(find_title);
            $(".sys-info-title-txt").val(find_title);
            $(".sys-info-desc-txt").val(find_desc);
        }
    });

    // 전체 선택 체크박스 이벤트
    $('#check-all').on('change', function() {
        $('.task-checkbox').prop('checked', $(this).is(':checked'));
    });

    // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
    $('.task-checkbox').on('change', function() {
        $('#check-all').prop('checked', $('.task-checkbox:checked').length === $('.task-checkbox').length);
    });

    // 업무명을 클릭할 때 sub-info-table 내용 변경
    $('.task-link').on('click', function(event) {
        event.preventDefault(); // 링크 기본 동작 방지

        // data-task와 data-desc 속성으로 값 가져오기
        const taskName = $(this).data('task');
        const taskDesc = $(this).data('desc');

        $('.sub-info-table').show();

        // sub-info-table의 내용 업데이트
        $('.sub-info-title-txt').val(taskName);
        $('.sub-info-desc-txt').val(taskDesc);
    });

});

function getSystemList() {
    return $.ajax({
        url: '/systems',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            let append_html = "";

            response.forEach(function(item) {
                console.log(item);

                append_html += `
                    <tr>
                        <td class="td-tab1" id="${item.systemNo}">
                            <span class="title">${item.systemTitle}</span>
                            <span class="system-dis">${item.systemContent}</span>
                        </td>
                     </tr>
                    `;
                if (item.subSystems) {
                    item.subSystems.forEach(function(subItem) {
                        append_html += `
                            <tr>
                                <td class="td-tab2" id="${subItem.systemNo}">
                                    <span class="title">${subItem.systemTitle}</span>
                                    <span class="system-dis">${subItem.systemContent}</span>
                                </td>
                            </tr>
                            `;
                    });
                }
            });

            $('.system-table').append(append_html);

        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });

}
