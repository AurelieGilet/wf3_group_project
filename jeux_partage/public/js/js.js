$(document).ready(function() {

    // menu burger
    $("#burger").on("click", function() {
        $(".cross_line").fadeToggle(100);
        $(".cross_off").fadeToggle(100);
        $("#cross_line1").toggleClass("rotate1");
        $("#cross_line2").toggleClass("rotate2");
        $("#overlay").fadeToggle(500);
        $("header ul").fadeToggle(500);
    });
    $("#burger").on("click", function() {
        if($(".cross_line").css({"display" : "block"}))
            $(".cross_line").css({"background-color" : "#f7cc99"})
        else
            $(".cross_line").css({"background-color" : "#000a1e"})
    });
    $('#overlay').click(function(){
        $('#burger').trigger('click');
    });

    // nav_hover
    $("header li").on("mouseenter", function() {
        $(this).siblings().css({"display" : "block"});
        $(this).siblings().animate({"width" : "84%"});
    });
    $("header li").on("mouseleave", function() {
        $(this).siblings().css({"display" : "none"});
        $(this).siblings().animate({"width" : "0"});
    });

    // .underline_a (soulignement liens a)
    $(".underline_a").on("mouseover", function() {
        $(this).css({"text-decoration-line" : "underline"});
        $(this).css({"text-decoration-color" : "#f3bc75"});
    });
    $(".underline_a").on("mouseout", function() {
        $(this).css({"text-decoration-line" : "none"});
        $(this).css({"text-decoration-color" : "transparent"});
    });

    // illustrations background main
    setInterval(function() {
        $("#circle1, #circle2, #circle4, #circle5").animate({"opacity" : "0.5"}, 6000);
        $("#circle1, #circle2, #circle4, #circle5").animate({"opacity" : "0.05"}, 6000);
    
        $("#circle3").animate({"opacity" : "1"}, 6000);
        $("#circle3").animate({"opacity" : "0.6"}, 6000);
    });
    
    // $("#circle1, #circle2, #circle4, #circle5").on("mouseover", function() {
    //     $(this).css({"opacity" : "0.7"});
    // });
    // $("#circle1, #circle2, #circle4, #circle5").on("mouseout", function() {
    //     $(this).css({"opacity" : "0.15"});
    // });
    // $("#circle3").on("mouseover", function() {
    //     $(this).css({"opacity" : "1"});
    // });
    // $("#circle3").on("mouseout", function() {
    //     $(this).css({"opacity" : "0.6"});
    // });


    // affichage nom fichier photo jeu
    $('.custom-file-input').on('change', function(event) {
        var inputFile = event.currentTarget;
        $(inputFile).parent()
            .find('.custom-file-label')
            .html(inputFile.files[0].name);
    });

});
