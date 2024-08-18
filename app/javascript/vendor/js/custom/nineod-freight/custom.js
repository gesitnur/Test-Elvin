import AOS from 'aos';

$(document).ready(function () {
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $(".navigation").css("background", "#fff");
    } else {
      $(".navigation").css("background", "transparent");
    }
    $(".navigation").toggleClass(
      "navbar-dark",
      $(this).scrollTop() < 100
    );
    $(".img-logo-black").toggleClass("d-none", $(this).scrollTop() < 100);
    $(".img-logo").toggleClass("d-none", $(this).scrollTop() > 100);
  });

  $(".menu-toggle").click(function () {
    $(".navigation").toggleClass("bg-white");

    $(window).scroll(function () {
      if ($(this).scrollTop() < 100) {
        $(".navigation").toggleClass("navbar-dark");
        $(".img-logo").toggleClass("d-none");
        $(".img-logo-black").toggleClass("d-none");
      }
    });

    $(".navigation").toggleClass("navbar-dark");
    $(".img-logo").toggleClass("d-none");
    $(".img-logo-black").toggleClass("d-none");

    $(".bar2").toggleClass("change");
    $(".bar1").toggleClass("change");
    $(".bar3").toggleClass("change");
  });

  const wScroll = $(this).scrollTop();

  AOS.init({
    once: true,
  });
});