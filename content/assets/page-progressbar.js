$(document).ready(function() {
  var docHeight = $(document).height();
  var windowHeight = $(window).height();
  var scrollPercent = 0;
  $(window).scroll(function() {
    scrollPercent = $(window).scrollTop() / (docHeight - windowHeight) * 100;
    $('#progress').width(scrollPercent + '%');
  });
});
