function imgFade() {
    $("div[class*='fade']").bind("mouseenter",function(){
        $(this).animate({opacity: 1}, 150);
    }).bind("mouseleave",function(){
        $(this).animate({opacity: 0.2}, 150);
    });
};

function nextLink() {
    $("div[class*='link']").bind("mouseenter",function(){
        $(this).animate({height: "40px"}, 150);
        $(this).css( 'cursor', 'pointer' );
    }).bind("mouseleave",function(){
        $(this).animate({height: "20px"}, 150);
    }).bind("click",function() {
        window.location = $(this).find("a:first").attr("href");
    });
};

$(function(){
     $("div.hover").bind("mouseenter",function(){
            this$ = $(this)
            this$.animate({ backgroundColor: "white" }, 150);
            this$.find("a").animate({ color: "#000" }, 150);
            this$.find("h3").animate({ color: "#000" }, 150);
            this$.find("h4").animate({ color: "#000" }, 150);
            this$.find("div[class*='copy']").animate({ color: "#000" }, 150);
            this$.css( 'cursor', 'pointer' );
        }).bind("mouseleave",function(){
            this$ = $(this)
            this$.animate({ backgroundColor: $(this).find("h2").attr("alt") }, 150);
            this$.find("a").animate({ color: "white" }, 150);
            this$.find("h3").animate({ color: "white" }, 150);
            this$.find("h4").animate({ color: "white" }, 150);
            this$.find("div[class*='copy']").animate({ color: "white" }, 150);
        }).bind("click",function() {
            window.location = $(this).find("a:first").attr("href");
        });
})

