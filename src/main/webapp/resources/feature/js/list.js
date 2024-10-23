function openFeaturePopup(){
    window.open(
        "/projects/features/register",
        "기능등록",
        "width=810, height=620, resizable=yes"
    );
}

$(document).ready(function (){

    $(document).on('click', '.feat-info-row', function() {
        $(this).siblings().removeClass("on");
        $(this).addClass("on");
    });

})
