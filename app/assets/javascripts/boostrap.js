$(function() {
  bootstrap.setTooltipDirection('right');
});

const bootstrap = {
  setTooltipDirection: function(direction) {
    $(".material-icons").tooltip({placement: direction});
  }
};
