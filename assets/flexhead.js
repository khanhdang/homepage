window.onscroll = function () {
    var scroll = window.pageYOffset;
    var navbar = document.getElementById("nav-container");
    var logo = document.getElementById("logo");
    if (document.documentElement.clientWidth <= 992 ) {
        logo.src = "assets/logo_long.svg"
    }
    if (scroll >= 150) {
        navbar.classList.add("small-header");
        navbar.classList.remove("big-header");
        logo.src = "assets/logo_long.svg"

    }
    else {
        if (scroll < 20) {
            navbar.classList.remove("small-header");
            navbar.classList.add("big-header");
            if (document.documentElement.clientWidth > 992 ) {
                logo.src = "assets/logo.svg"
            }
            
        }

    }
};
