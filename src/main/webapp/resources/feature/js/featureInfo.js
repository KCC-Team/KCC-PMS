$(document).ready(function (){
    window.addEventListener("message", function(event) {
        if (event.data.type === 'featureMember') {
            let receivedMember = event.data.member;
            console.log("받은 멤버 :", receivedMember);

            document.getElementById("mem_no").value = receivedMember[0].id;
            document.getElementById("mem_nm").value = receivedMember[0].memberName;
            document.getElementById("tm_no").value = receivedMember[0].teamNo;
        }
    }, false);

    console.log("prjNo = " + prjNo)

    fetchOptions();


    $("#pre_st_dt, #pre_end_dt, #st_dt, #end_dt").datepicker({
        dateFormat: "yy-mm-dd"  // 원하는 형식으로 날짜 표시
    });


    $(".btn-save-feature").on("click", function (e) {
        e.preventDefault();
        const formData = $("#feat_form").serializeArray();
        const formDataObject = {};

        formData.forEach(function(item) {
            formDataObject[item.name] = item.value;
        });

        // 'featClassCode'가 선택되지 않았다면 기본값 'PMS01005'를 설정
        if (!formDataObject.featClassCode || formDataObject.featClassCode === "") {
            formDataObject.featClassCode = "PMS01005";
        }

        console.log("Form Data:", formDataObject);


        $.ajax({
            type: "POST",
            url: "/projects/features",
            data: formDataObject,
            success: function (response) {
                alert("저장이 완료되었습니다.");
            },
            error: function (xhr, status, error) {
                alert("저장 중 문제가 발생했습니다. 다시 시도해주세요.");
                console.log(xhr, status, error);
            }
        });
    });

    fetchMenuData().then(function(menuData) {
        createMenu(menuData);
    });

    $('#system-select').click(function() {
        $('#system-menu').slideToggle();  // 메뉴를 보여주거나 숨기기
    });

    $("#system-select span:first").text("시스템 선택");

})



function fetchOptions() {
    $.ajax({
        url: '/projects/features/options',
        method: 'GET',
        success: function(data) {
            console.log(data)
            data.forEach(function(item) {
                console.log(item);
                const selectId = '#' + item.common_cd_no;
                const $selectElement = $(selectId);

                if ($selectElement.length) {
                    setOptions($selectElement, item.codes);

                }
            });
        },
        error: function(xhr, status, error) {
            console.error('옵션 데이터를 가져오는데 실패했습니다.', error);
        }
    });
}

function setOptions($selectElement, options) {
    options.forEach(function(option) {
        if (option.cd_dtl_no !== 'PMS01005') {
            // 각 option 태그 생성
            const $option = $('<option>', {
                value: option.cd_dtl_no,
                text: option.cd_dtl_nm
            });

            $selectElement.append($option);
        }
    });
}

function fetchMenuData() {
    return $.ajax({
        url: '/systems?prjNo=' + prjNo,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("systems: " + response);
            return response;
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}


function createMenu(menuData) {
    createMenuHTML(menuData, $('#system-menu'), "");
}

function createMenuHTML(menuData, parentElement, path) {
    menuData.forEach(function(menuItem) {
        const listItem = $('<li class="menu-item"></li>').text(menuItem.systemTitle);
        const subMenu = $('<ul class="system-submenu"></ul>');

        const currentPath = path ? path + " > " + menuItem.systemTitle : menuItem.systemTitle;

        // 하위 메뉴가 있는 경우
        if (menuItem.subSystems && menuItem.subSystems.length > 0) {
            createMenuHTML(menuItem.subSystems, subMenu, currentPath);
            listItem.append(subMenu);
        }

        listItem.click(function(event) {
            event.stopPropagation();
            $('#system-select span:first-child').text(currentPath);  // 사용자가 선택한 경로 표시
            $('#systemNo').val(menuItem.systemNo);  // systemNo를 숨겨진 필드에 저장
            $('.mymenu').slideUp();  // 메뉴 숨기기
        });

        parentElement.append(listItem);
    });
}