function openFeaturePopup(){
    window.open(
        "/projects/features/register",
        "기능등록",
        "width=720, height=590, resizable=yes"
    );
}

$(document).ready(function (){

    $(document).on('click', '.feat-info-row', function() {
        $(this).siblings().removeClass("on");
        $(this).addClass("on");
    });

})
