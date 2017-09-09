`
function add_correct_solution() {
  const container = $('#generated_correct_solutions');
  var wrapper = $('<div>', { class: 'input-wrapper input-group' }).appendTo(container);
  $('<input>', {name: 'task[correct_solutions][]', type: 'text', class: 'form-control'}).appendTo(wrapper);
  var input_wrapper = $('<span>', {class: 'input-group-addon remove_correct_solution'}).appendTo(wrapper);
  $('<i>', {class: 'glyphicon glyphicon-remove'}).appendTo(input_wrapper);
};

function add_wrong_solution() {
  const container = $('#generated_wrong_solutions');
  var wrapper = $('<div>', { class: 'input-wrapper input-group' }).appendTo(container);
  $('<input>', {name: 'task[wrong_solutions][]', type: 'text', class: 'form-control'}).appendTo(wrapper);
  var input_wrapper = $('<span>', {class: 'input-group-addon remove_wrong_solution'}).appendTo(wrapper);
  $('<i>', {class: 'glyphicon glyphicon-remove'}).appendTo(input_wrapper);
}

$(function() {
  const correct_solutions = $('#correct_solutions_params').data('correct-solutions');
  const wrong_solutions = $('#wrong_solutions_params').data('wrong-solutions');
  if (typeof correct_solutions != 'undefined') {
    $.each(correct_solutions, function(key, value) {
      add_correct_solution();
      $('#generated_correct_solutions input').last().val(value);
    });
  }
  if (typeof wrong_solutions != 'undefined') {
    $.each(wrong_solutions, function(key, value) {
      add_wrong_solution();
      $('#generated_wrong_solutions input').last().val(value);
    });
  }
});

$(document).on('turbolinks:load', function() {
  if ($('#type_of_task').val()  == 'Close-ended') {
    const container = $('#close-ended_task');
    container.removeClass('hidden');
  }

  if ($('#randomize_task').prop('checked')) {
    const container = $('#randomize');
    container.removeClass('hidden');
  }

  $('#type_of_task').change( function() {
    const container = $('#close-ended_task');
    if ($(this).val()  === 'Close-ended') {
      container.hide().removeClass('hidden').slideDown(400);
    }
    else {
      container.slideUp(400);
    }
  });

  $('#randomize_task').change( function() {
    const container = $('#randomize');
    if ($(this).prop('checked')) {
      container.hide().removeClass('hidden').slideDown(400);
    }
    else {
      container.slideUp(400);
    }
  });

  $('#add_correct_solution').on('click', add_correct_solution);

  $('#generated_correct_solutions').on('click', '.remove_correct_solution', function() {
    $(this).parent().remove();
  });

  $('#add_wrong_solution').on('click', add_wrong_solution);

  $('#generated_wrong_solutions').on('click', '.remove_wrong_solution', function() {
    $(this).parent().remove();
  });

  $('#picture-input').on('change', function(event) {
    const files = event.target.files;
    const image = files[0];
    const target = $('#preview');
    var reader = new FileReader();
    reader.onload = function(file) {
      let img = new Image();
      img.src = file.target.result;
      target.html(img);
      target.children('img').addClass('img-responsive');
    }
    reader.readAsDataURL(image);
  });
});
`