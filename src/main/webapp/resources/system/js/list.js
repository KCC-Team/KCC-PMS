$(document).ready(function () {
    getSystemList();

    // 로드 될때 첫번째 업무 시스템 클릭
    setTimeout(function() {
        let thirdTd = $('.system-table td').eq(1);
        if (thirdTd.length) {
            thirdTd.trigger('click');
        }
    }, 100);

    setTimeout(function() {
        $('.tr-work-list').each(function (index, element) {
            var id = $(element).attr('id');
            if (id == 1) {
                $(element).show();
            } else {
                $(element).hide();
            }
        });
    }, 100);

    // 시스템 클릭시 동작
    $('.system-table').on('click', 'td', function() {
        if ($(this).attr("id") != null) {
            $('.system-table td').removeClass('active'); // 모든 td에서 active 클래스 제거
            $(this).addClass('active'); // 클릭한 td에만 active 클래스 추가

            let find_title = $(this).children(".title").text();
            let find_desc = $(this).children(".system-dis").text();

            $(".system-info").text(find_title);
            $(".sys-info-title-txt").val(find_title);
            $(".sys-info-desc-txt").val(find_desc);

            $('.sub-info-table').hide();
            $('.btn-save-work').hide();
            $(".btn-sys-delete").show();
            $(".system-content.work").show();
            $(".submenu-list-table").show();

            $(".tr-work-list").hide();
            $(".tr_" + $(this).attr("id")).show();
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
    $(document).on('click', '.task-link', function(event) {
        event.preventDefault(); // 링크 기본 동작 방지

        // data-task와 data-desc 속성으로 값 가져오기
        const taskName = $(this).data('task');
        const taskDesc = $(this).data('desc');

        $('.sub-info-table').show();
        $('.btn-save-work').show();

        // sub-info-table의 내용 업데이트
        $('.sub-info-title-txt').val(taskName);
        $('.sub-info-desc-txt').val(taskDesc);
    });

});

// 시스템 조회
function getSystemList() {
    return $.ajax({
        url: '/systems',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            let append_html = "";
            let work_append_html = ""

            response.forEach(function(item) {
                // 시스템 리스트
                append_html += `
                    <tr>
                        <td class="td-tab1" id="${item.systemNo}">
                            <span class="title">${item.systemTitle}</span>
                            <span class="system-dis">${item.systemContent}</span>
                        </td>
                     </tr>
                    `;
                // 하위 업무 리스트
                if (item.subSystems) {
                    item.subSystems.forEach(function(subItem) {
                        console.log(subItem);

                         work_append_html += `
                            <tr id="${subItem.parentSystemNo}" class="tr-work-list tr_${subItem.parentSystemNo}">
                                <td class="submenu-list-title">
                                    <input type="checkbox" name="task" class="task-checkbox">
                                </td>
                                <td>
                                    <a href="#" class="task-link" id="${subItem.systemNo}" data-task="${subItem.systemTitle}" data-desc="${subItem.systemContent}">${subItem.systemTitle}</a>
                                </td>
                                <td>
                                    ${subItem.systemContent}
                                </td>
                            </tr>
                            `;
                    });
                }
            });

            $('.system-table').append(append_html);
            $('.submenu-list-table').append(work_append_html);
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}

// 시스템 등록 버튼 클릭
function system_register() {
    $(".system-info").text("시스템 등록");
    $(".btn-sys-delete").hide();
    $(".system-content.work").hide();
    $(".submenu-list-table").hide();
    $('.sys-info-title-txt').val('');
    $('.sys-info-desc-txt').val('');
}

// 업무 등록 버튼 클릭
function register_work() {
    $('.sub-info-table').show();
    $('.btn-save-work').show();
    $('.sub-info-title-txt').val('');
    $('.sub-info-desc-txt').val('');
}