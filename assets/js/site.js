import $ from 'jquery';
import 'bootstrap';

// function toggleDropdown (e) {
//   const _d = $(e.target).closest('.dropdown'),
//     _m = $('.dropdown-menu', _d);
//   setTimeout(function(){
//     const shouldOpen = e.type !== 'click' && _d.is(':hover');
//     _m.toggleClass('show', shouldOpen);
//     _d.toggleClass('show', shouldOpen);
//     $('[data-toggle="dropdown"]', _d).attr('aria-expanded', shouldOpen);
//   }, e.type === 'mouseleave' ? 100 : 0);
// }

// $('body')
//   .on('mouseenter mouseleave touchstart','.dropdown',toggleDropdown)
//   .on('click', '.dropdown-menu a', toggleDropdown);

/*!
 * Bootstrap 4 multi dropdown navbar ( https://bootstrapthemes.co/demo/resource/bootstrap-4-multi-dropdown-navbar/ )
 * Copyright 2017.
 * Licensed under the GPL license
 */
$(document).ready(function () {
  $('.dropdown-menu a.dropdown-toggle').on('click', function (e) {
    var $el = $(this);
    $el.toggleClass('active-dropdown');
    var $parent = $(this).offsetParent(".dropdown-menu");
    if (!$(this).next().hasClass('show')) {
      $(this).parents('.dropdown-menu').first().find('.show').removeClass("show");
    }
    var $subMenu = $(this).next(".dropdown-menu");
    $subMenu.toggleClass('show');

    $(this).parent("li").toggleClass('show');

    $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function (e) {
      $('.dropdown-menu .show').removeClass("show");
      $el.removeClass('active-dropdown');
    });

    if (!$parent.parent().hasClass('navbar-nav')) {
      $el.next().css({
        "top": $el[0].offsetTop,
        "left": $parent.outerWidth() - 4
      });
    }

    return false;
  });
});

window.cookieconsent.initialise({
  "palette": {
    "popup": {
      "background": "#252e39"
    },
    "button": {
      "background": "#14a7d0"
    }
  }
});
