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