jQuery(function ($) {
    let pageWrapper = $(".page-wrapper");
    $("#close-sidebar").click(function() {
        pageWrapper.removeClass("toggled");
    });
    $("#show-sidebar").click(function() {
        pageWrapper.addClass("toggled");
    });

    $(window).bind("resize", function() {
        console.log($(this).width())
        if($(this).width() < 768) {
            pageWrapper.removeClass("toggled");
        } else {
            pageWrapper.addClass("toggled");
        }
    })
});