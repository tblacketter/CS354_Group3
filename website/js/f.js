/**
 * F* Programming Language Spotlight
 * 
 * f.js (f*)
 * All the javascript used on this site.
 */

/**
 * Handles when the user scrolls.
 */
$(window).on("scroll", function () {
    const shadowThreshold = 20;
    const header = $("header");
    const topSpan = $("#top-span");

    if ($(this).scrollTop() > shadowThreshold) {
        header.addClass('shadow');
        topSpan.fadeIn();
    } else {
        header.removeClass('shadow');
        topSpan.fadeOut();
    }
});

/**
 * Anything inside this block executes once the document is "ready".
 */
$(document).ready(() => {
    adjustTopPadding();
    loadFStarCode();
});

/**
 * Asjust the padding at the top of the page to allow for perfect
 * alignment for the body content and the header.
 */
const adjustTopPadding = () => {
    const header = $("header");
    const body = $("body");
    const headerHeight = header.outerHeight();
    body.css('padding-top', `${headerHeight}px`);
};

/**
 * Scrolls to the top of the page.
 * 
 * @param {object} e - The element object instance.
 */
const scrollToTop = (e) => {
    const $span = $(`#${$(e).data('span')}`);
    $span.fadeOut();
    $("html, body").animate({ scrollTop: 0 }, "slow");
};

/**
 * Load F* code into <code> blocks from external files.
 */
const loadFStarCode = () => {
    const targets = [
        { id: "connection", path: "code/Connection.fst" },
        { id: "connection-terminal", path: "terminal/connection.txt" },
        { id: "comm", path: "code/Commutative.fst" },
        { id: "comm-terminal", path: "terminal/comm.txt" },
        { id: "commbad", path: "code/CommutativeBad.fst" },
        { id: "commbad-terminal", path: "terminal/commbad.txt" }
    ];

    targets.forEach(({ id, path }) => {
        const el = document.getElementById(id);
        if (!el) return;

        fetch(path)
            .then(r => r.text())
            .then(code => {
                el.textContent = code;     // no HTML injection
                if (window.Prism) {
                    Prism.highlightElement(el);
                }
            })
            .catch(err => {
                console.error(`Failed to load ${path}`, err);
            });
    });
};