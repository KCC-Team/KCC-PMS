document.getElementById('toggle-btn').addEventListener('click', function() {
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const header_content = document.querySelector(".header");
    const toggleBtn = document.getElementById('toggle-btn');

    sidebar.classList.toggle('hidden'); // 사이드바 숨기기/보이기
    content.classList.toggle('expanded'); // 콘텐츠 확장/축소
    header_content.classList.toggle('expanded'); // 콘텐츠 확장/축소
    toggleBtn.classList.toggle('collapsed'); // 버튼 위치 변경

    // 화살표 방향 변경
    const arrow = toggleBtn.querySelector('.arrow');
    if (arrow.innerHTML === '←') {
        arrow.innerHTML = '→';
    } else {
        arrow.innerHTML = '←';
    }
});

// 모든 메인 메뉴에 클릭 이벤트를 추가하여 하위 메뉴 토글
document.querySelectorAll('.menu > li > a').forEach(menu => {
    menu.addEventListener('click', function() {
        // 클릭된 메뉴에 하위에 있는 서브메뉴를 찾음
        const submenu = this.nextElementSibling;
        const parentLi = this.parentElement;

        // 서브메뉴가 있을 경우에만 작동
        if (submenu && submenu.classList.contains('submenu')) {
            submenu.classList.toggle('visible'); // 서브메뉴 가시성 토글
            parentLi.classList.toggle('collapsed'); // 화살표 방향 토글
        }
    });
});

commonProjectInfo();

function commonProjectInfo() {
    $.ajax({
        url: '/projects',
        type: 'GET',
        success: function (response) {
            let li_project = "";
            response.forEach(function(project) {
                li_project += `<li>
                                <a class="dropdown-item li-project" href="#" data-prj-no="${project.prj_no}">
                                    ${project.prj_title}
                                </a>
                                </li>`;
            });
            $(".ul-prj-title").append(li_project);
            //$(".common-project-title").text(prjTitle);
        },
        error: function (xhr, status, error) {
            console.error('에러:', xhr.responseText);
        }
    });
}

$(document).on('click', '.li-project', function() {
    let prjNo = $(this).data('prj-no');
    let prjTitle = $(this).text();

    $.ajax({
        url: '/commonProjectInfo',
        type: 'GET',
        data: {
            prjNo: prjNo,
            prjTitle: prjTitle
        },
        success: function (response) {
            location.reload();
        },
        error: function (xhr, status, error) {
            console.error('에러:', xhr.responseText);
        }
    });
});
