// as seen on https://shauninman.com/pendium/
$(document).ready(function() {
  $("a").each(function() {
    $(this).mousemove(function(e) {
      if (this.isAlreadyAnimating) return;

      var baseExpX = 4;   // 2 ^ 4 == 16
      var baseExpY = 2;   // 2 ^ 4 == 16

      // element proportions
      var t = $(this);

      var w = this.offsetWidth;
      var h = this.offsetHeight;
      var hw = w/2;
      var hh = h/2;

      var offsets = t.offset(); // element position relative to page
      var pos = // mouse position relative to element
          {
            x : e.pageX - offsets.left,
            y : e.pageY - offsets.top
          };

      // mouse position offset from center of element
      var cx = pos.x - hw;
      var cy = pos.y - hh;

      // percentage from center to edge
      var px = Math.abs(cx/hw);
      var py = Math.abs(cy/hh);

      // new top/left positions
      var nx = Math.round(Math.pow(2, px * baseExpX)) * (cx < 0 ? -1 : 1);
      var ny = Math.round(Math.pow(2, py * baseExpY)) * (cy < 0 ? -1 : 1);

      t.css({
        zIndex  : 10,
        left   : nx + 'px',
        top   : ny + 'px',
        position: "relative"
      });
    });

    // out
    $(this).mouseout(function(e) {
      var t = $(this);
      var pos = {
        x: parseInt(t.css('left')),
        y: parseInt(t.css('top'))
      };

      this.isAlreadyAnimating = true;
      [
        {factor: -1, duration: 50},
        {factor: .75, duration: 75},
        {factor: -.5, duration: 50},
        {factor: .25, duration: 100},
        {factor: 0.0, duration: 100, doneCallback: function() {t.css({zIndex: 0});this.isAlreadyAnimating = false;}}]
          .forEach(i => t.animate({top: pos.y * i.factor, left: pos.x * i.factor}, i.duration, "swing", i.doneCallback));
    });
  });
});
