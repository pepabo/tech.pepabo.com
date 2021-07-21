window.addEventListener('DOMContentLoaded', function () {
  var $content = document.querySelectorAll('.wrapper'),
  $drawer = document.querySelectorAll('.js-drawer'),
  $button = document.querySelectorAll('.js-drawer--trigger'),
  $overlay = document.querySelectorAll('.overlay'),
  isOpen = false;

  function setClass(isValid) {
    if (isValid) {
      $drawer.forEach(function (elem) {
        elem.classList.add('open');
      });
      $content.forEach(function (elem) {
        elem.classList.add('open');
      });
    } else {
      $drawer.forEach(function (elem) {
        elem.classList.remove('open');
      });
      $content.forEach(function (elem) {
        elem.classList.remove('open');
      });
    }
  }

  function fade(isValid) {
    $overlay.forEach(function (elem) {
      if (isValid) {
        elem.classList.add('fade-in', 'active');
        setTimeout(function () {
          elem.classList.remove('fade-in');
        }, 300);
      } else {
        elem.classList.add('fade-out');
        setTimeout(function () {
          elem.classList.remove('fade-out', 'active');
        }, 300);
      }
    });
  }

  function toggleDrawer() {
    setClass(!isOpen);
    isOpen = !isOpen;
    fade(true);
    return false;
  }

  $button.forEach(function (elem) {
    elem.addEventListener('touchstart', toggleDrawer);
    elem.addEventListener('click', toggleDrawer);
  });

  function closeDrawer(e) {
    e.stopPropagation();
    if (isOpen) {
      setClass(false);
      fade(false);
      isOpen = false;
    }
  }

  $overlay.forEach(function (elem) {
    elem.addEventListener('touchstart', closeDrawer);
    elem.addEventListener('click', closeDrawer);
  });

  document.querySelectorAll("a[href^='http']:not([href*='" + location.hostname + "'])")
    .forEach(function (elem) {
      elem.setAttribute('target', '_blank');
    });
});
