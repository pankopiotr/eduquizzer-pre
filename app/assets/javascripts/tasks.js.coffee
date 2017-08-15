`
$(function() {
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

  $('#add_correct_solution').on('click', function() {
    const container = $('#generated_correct_solutions');
    var wrapper = $('<div>', { class: 'input-wrapper input-group' }).appendTo(container);
    $('<input>', {name: 'task[correct_solutions][]', type: 'text', class: 'form-control'}).appendTo(wrapper);
    var input_wrapper = $('<span>', {class: 'input-group-addon remove_correct_solution'}).appendTo(wrapper);
    $('<i>', {class: 'glyphicon glyphicon-remove'}).appendTo(input_wrapper);
  });

  $('#generated_correct_solutions').on('click', '.remove_correct_solution', function() {
    $(this).parent().remove();
  });

  $('#add_wrong_solution').on('click', function() {
    const container = $('#generated_wrong_solutions');
    var wrapper = $('<div>', { class: 'input-wrapper input-group' }).appendTo(container);
    $('<input>', {name: 'task[wrong_solutions][]', type: 'text', class: 'form-control'}).appendTo(wrapper);
    var input_wrapper = $('<span>', {class: 'input-group-addon remove_wrong_solution'}).appendTo(wrapper);
    $('<i>', {class: 'glyphicon glyphicon-remove'}).appendTo(input_wrapper);
  });

  $('#generated_wrong_solutions').on('click', '.remove_wrong_solution', function() {
    $(this).parent().remove();
  });
});
`