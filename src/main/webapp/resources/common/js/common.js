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

function openTeamPopUp(type){
    let height;

    if (type === 'feature' || type === 'defect1' || type === 'defect2' || type.includes('test_')) {
        height = 480;
    } else {
        height = 700;
    }

    console.log(height);

    window.open(
        "/projects/addTeamMember?type=" + type,
        "그룹등록",
        "width=1000, height=" + height + ", resizable=yes"
    );
}

document.addEventListener('DOMContentLoaded', function() {
    // 현재 페이지의 URL 경로를 가져옵니다.
    var currentPath = window.location.pathname;

    // 모든 사이드바 메뉴의 링크를 선택합니다.
    var menuLinks = document.querySelectorAll('.menu a');

    menuLinks.forEach(function(link) {
        var linkPath = link.getAttribute('href');

        // 현재 경로와 링크의 경로를 비교합니다.
        console.log(linkPath);
        if (currentPath.includes(linkPath)) {
            link.classList.add('active');

            // 부모 메뉴가 서브메뉴인 경우, 해당 서브메뉴를 펼칩니다.
            var submenu = link.closest('.submenu');
            if (submenu) {
                submenu.classList.add('visible');

                var parentMenu = submenu.parentElement;
                if (parentMenu) {
                    parentMenu.classList.remove('collapsed');
                }
            }
        }
    });
});

$(function () {
    $(document).on('click', '.add-defect', function(e) {
        e.preventDefault();
        let popup = window.open('/projects/defects/defect?featureId=RTS_1002_01&featttl=wbs작업목록조회', 'popup', 'width=1150, height=810');
    });
});