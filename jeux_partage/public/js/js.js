$(document).ready(function() {

    // menu burger
    $("#burger").on("click", function() {
        $(".cross_line").fadeToggle(100);
        $(".cross_off").fadeToggle(100);
        $("#cross_line1").animate({"rotate" : "-45deg",
                                "translate" : "1.5px"});
        $("#cross_line2").animate({"rotate" : "45deg"});
        $("#overlay").fadeToggle(500);
        $("header ul").fadeToggle(500);
    });
    $("#burger").on("click", function() {
        if($(".cross_line").css({"display" : "block"}))
            $(".cross_line").css({"background-color" : "#f7cc99"})
        else
            $(".cross_line").css({"background-color" : "#000a1e"})
    });

    // nav_hover
    $("header li").on("mouseenter", function() {
        $(this).siblings().css({"display" : "block"});
        $(this).siblings().animate({"width" : "76%"});
        $(this).css({"color" : "#8a0030"});
    });
    $("header li").on("mouseleave", function() {
        $(this).siblings().css({"display" : "none"});
        $(this).siblings().animate({"width" : "0"});
        $(this).css({"color" : "#000a1e"});
    });

    // #ici
    $("#ici").on("mouseover", function() {
        $(this).css({"text-decoration-line" : "underline"});
        $(this).css({"text-decoration-color" : "#f3bc75"});
    });
    $("#ici").on("mouseout", function() {
        $(this).css({"text-decoration-line" : "none"});
        $(this).css({"text-decoration-color" : "transparent"});
    });

    // // formulaires
    // $("input").focus(function() {
    //     $(this).css({"border-bottom" : "rgb(0, 10, 30) solid 3px"})
    // });

});
