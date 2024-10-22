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

    fetchOptions();

    $("#pre_st_dt, #pre_end_dt, #st_dt, #end_dt").datepicker({
        dateFormat: "yy-mm-dd"  // 원하는 형식으로 날짜 표시
    });


    $(".btn-save-feature").on("click", function (e) {
        e.preventDefault(); 
        const formDataArray = $("#feat_form").serializeArray();
        const formDataObject = {};

        formDataArray.forEach(function(item) {
            formDataObject[item.name] = item.value;
        });

        console.log("Form Data:", formDataObject);


        // $.ajax({
        //     type: "POST",
        //     url: "/your-server-endpoint", // 서버의 실제 엔드포인트로 변경
        //     data: formData,
        //     success: function (response) {
        //         // 서버 응답이 성공적일 때 수행할 작업
        //         alert("저장이 완료되었습니다.");
        //         // 추가적으로 모달 닫기 또는 화면 새로고침 등 필요시 작성
        //     },
        //     error: function (xhr, status, error) {
        //         // 에러가 발생할 때 수행할 작업
        //         alert("저장 중 문제가 발생했습니다. 다시 시도해주세요.");
        //         console.log(xhr, status, error);
        //     }
        // });
    });

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
        // 각 option 태그 생성
        const $option = $('<option>', {
            value: option.cd_dtl_no,
            text: option.cd_dtl_nm
        });

        $selectElement.append($option);
    });
}