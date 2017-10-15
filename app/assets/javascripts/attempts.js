$(document).on('turbolinks:load', function() {
  attempt.initialize();
});

attempt = {

  getTimeLeft: function() {
    const timeEnd = $('#timer_params').data('attempt-sec-left');
    let seconds_left = timeEnd - Math.floor(Date.now() / 1000);
    if (seconds_left <= 0)
    {
      seconds_left = 0;
      attempt.stopTimer(timer);
    }
    const time_left = new Date(seconds_left * 1000).toISOString().substr(11, 8);
    $('#timer').children('p').text(time_left);
  },

  initialize: function() {
    if ($('#timer').length) { attempt.startTimer(); }
  },

  startTimer: function() {
    attempt.getTimeLeft();
    window.timer = setInterval(attempt.getTimeLeft, 1000);
  },

  stopTimer: function(timer) {
    clearInterval(timer);
  }

};