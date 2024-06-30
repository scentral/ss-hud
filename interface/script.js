window.addEventListener("message", function(event) {
    const item = event.data;
    if (item.type === "hud") {
        $("#health").css("width", item.health + "%");
    }

    if (item.type === "armour") {
        if (item.show) {
            $("#armor").css("width", item.armour + "%");
            $(".armor-bar").fadeIn();
        } else {
            $(".armor-bar").fadeOut();
        }
    }

    if (item.type === "radar") {
        if (item.show) {
            $(".minimap").fadeIn();
        } else {
            $(".minimap").fadeOut();
        }
    }

    if (item.type === "breath") {
        if (item.show) {
            $("#breath").css("width", item.time + "%");
            $(".breath-bar").fadeIn();
        } else {
            $(".breath-bar").fadeOut();
        }
    }
});