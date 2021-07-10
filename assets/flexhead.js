window.onscroll = function () {
    var scroll = window.pageYOffset;
    var navbar = document.getElementById("nav-container");

    if (scroll >= 150) {
        navbar.classList.add("small-header");
        navbar.classList.remove("big-header");
    }
    else {
        if (scroll < 20) {
            navbar.classList.remove("small-header");
            navbar.classList.add("big-header");
        }

    }
};
