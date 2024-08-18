import AOS from 'aos';

$(document).ready(function () {
  var globalVar = {};
  $(this).scrollTop(0);
  // Burger menu
  $(".hamburger-menu").click(function () {
    $(this).toggleClass("open");
    $(".mobile-nav").toggleClass("is-active");
  });

  // Page scroll
  $(".nav-scroll, page-item a").click(function (e) {
    const element = $(this).attr("href").replace(/\//g, "");
    const goalElement = $(element);
    $("html").animate({
      scrollTop: goalElement.offset().top - 70,
    });
    $(".mobile-nav").toggleClass("is-active");
    $(".hamburger-menu").toggleClass("open");
    e.preventDefault();
  });

  $(window).scroll(function () {
    $(".active-scroll").each(function () {
      const sectionRowTop = $(this).offset().top - 500;
      if ($(window).scrollTop() > sectionRowTop) {
        $(".active-scroll").removeClass("active");
        globalVar.ActiveId = $(this).addClass("active").attr("id");
      }
    });
    $(".item-nav").each(function () {
      const thisChildrenHref = $(this).children("a").attr("href");
      if (thisChildrenHref === "/#" + globalVar.ActiveId) {
        $(".item-nav").removeClass("active");
        $(this).addClass("active");
      }
    });
    $(".page-item").each(function () {
      const thisChildren = $(this).children("a");
      const thisChildrenHref = $(this).children("a").attr("href");
      if (thisChildrenHref === "/#" + globalVar.ActiveId) {
        $(".page-item a").removeClass("active");
        $(thisChildren).addClass("active");
      }
    });
  });

  // Show websites
  $(".project-item-wrap").slice(0, 4).show();
  $(".show-more").click(function () {
    $(".project-item-wrap:hidden").slice(0, 4).slideDown(500);
    if ($(".project-item-wrap:hidden").length === 0) {
      $(".show-more").fadeOut(500);
    }
  });

  $(".project-item-wrap").slice(0, 6).show();
  $(".show-more").click(function () {
    $(".project-item-wrap:hidden").slice(0, 3).slideDown(500);
    if ($(".project-item-wrap:hidden").length === 0) {
      $(".show-more").fadeOut(500);
    }
  });

  // Slider
  $(".partners-body").slick({
    infinite: true,
    slidesToShow: 5,
    slidesToScroll: 3,
    varibleWidth: true,
    centerMode: true,
    speed: 1500,
    arrows: true,
    prevArrow: "",
    nextArrow: "",
    responsive: [
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        },
      },
    ],
  });

  $(".arrow-prev").mouseenter(function () {
    $(".partners-body").slick("slickPrev");
  });
  $(".arrow-next").mouseenter(function () {
    $(".partners-body").slick("slickNext");
  });

  $(".arrow-prev").click(function () {
    $(".partners-body").slick("slickPrev");
  });
  $(".arrow-next").click(function () {
    $(".partners-body").slick("slickNext");
  });

  $(".our-clients-content").slick({
    prevArrow: "",
    nextArrow: "",
    autoplay: true,
    dots: true,
    speed: 800,
    autoplaySpeed: 5000,
    cssEase: "cubic-bezier(.87,0,.13,1)",
  });

  $(".mobile-nav ul li:nth-child(4)").click(function () {
    $(this).children("ul").stop().slideToggle(400);
    $(".arrow-dropdown").toggleClass("active");
  });

  // AOS animation
  AOS.init({
    once: true,
    disable: function() {
      var maxWidth = 768;
      return window.innerWidth < maxWidth;
    }
  });

  // Search On section faq
  $(".search-icon").click(function () {
    $(this).toggleClass("active");
    $(".input-search").toggleClass("active");
    $(".btn-close").toggleClass("active");
  });
  $(".btn-close").click(function () {
    $(this).toggleClass("active");
    $(".input-search").toggleClass("active");
    $(".search-icon").toggleClass("active");
  });
  var showError = true;
  $(".message-empty").hide();
  $(".input-search").on("keyup", function () {
    const value = $(this).val().toLowerCase();
    if (value === "") {
      $(".message-empty").hide();
    } else if (showError) {
      $(".message-empty").show();
    }
    $(".accordion-item").each(function () {
      const htxt = $(this).text().toString().toLowerCase();
      const accIndex = $(this).index();
      if (htxt.indexOf(value) > -1) {
        $(this).show();
        $("#accordion-item-" + accIndex).attr("filter-key", value).show();
        showError = false;
      } else if ($(".accordion-item:visible").length === 0) {
        $(".message-empty").show();
      } else {
        $(this).hide();
        $(".message-empty").hide();
      }
    });
  });
});
