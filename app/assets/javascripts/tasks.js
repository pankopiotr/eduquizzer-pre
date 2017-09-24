$(document).on('turbolinks:load', function() {
  // add_solution requires on load instead of document ready
  task.initialize();
});

task = {
  solutionType: ['correct', 'wrong'],

  add_solution: function(type) {
    if (!task.solutionType.includes(type)) return;
    const $container = $('#generated_' + type + '_solutions');
    const wrapper = $('<div>', {class: 'input-wrapper input-group'}).appendTo($container);
    $('<input>', {name: 'task[' + type + '_solutions][]', type: 'text', class: 'form-control'}).appendTo(wrapper);
    const input_wrapper = $('<span>', {class: 'input-group-addon remove_' + type +'_solution'}).appendTo(wrapper);
    $('<i>', {class: 'glyphicon glyphicon-remove'}).appendTo(input_wrapper);
  },

  assetPreview: function(event) {
    const files = event.target.files;
    const image = files[0];
    const target = $('#preview');
    const reader = new FileReader();
    reader.onload = function(file) {
      let img = new Image();
      img.src = file.target.result;
      target.html(img);
      target.children('img').addClass('img-responsive');
    };
    reader.readAsDataURL(image);
  },

  initialize: function() {
    const correct_solutions = $('#correct_solutions_params').data('correct-solutions');
    const wrong_solutions = $('#wrong_solutions_params').data('wrong-solutions');
    console.log(correct_solutions);
    console.log(wrong_solutions);

    // Remember select on validation error
    if (String($('#type_of_task').val()) === 'Close-ended') {
      const container = $('#close-ended_task');
      container.removeClass('hidden');
    }
    // Remember check on validation error
    if ($('#randomize_task').prop('checked')) {
      const container = $('#randomize');
      container.removeClass('hidden');
    }
    // Remember correct solutions on validation error
    if (typeof correct_solutions !== 'undefined') {
      $.each(correct_solutions, function(key, value) {
        task.add_solution('correct');
        $('input[name="task[correct_solutions][]"]').last().val(value);
      });
    }
    // Remember wrong solutions on validation error
    if (typeof wrong_solutions !== 'undefined') {
      $.each(wrong_solutions, function(key, value) {
        task.add_solution('wrong');
        $('#generated_wrong_solutions').find('input').last().val(value);
      });
    }

    task.setEventListeners();
  },

  setEventListeners: function() {
    $('#add_correct_solution').on('click', function() {task.add_solution('correct');});
    $('#add_wrong_solution').on('click', function() {task.add_solution('wrong')});

    $('#generated_correct_solutions').on('click', '.remove_correct_solution', function() {
      $(this).parent().remove();
    });
    $('#generated_wrong_solutions').on('click', '.remove_wrong_solution', function() {
      $(this).parent().remove();
    });

    $('#type_of_task').on('change', task.toggleClosedType);
    $('#randomize_task').on('change', task.toggleRandomize);

    $('#picture-input').on('change', task.assetPreview);
  },

  toggleClosedType: function() {
    const container = $('#close-ended_task');
    if ($(this).val()  === 'Close-ended') {
      container.hide().removeClass('hidden').slideDown(400);
    }
    else {
      container.slideUp(400);
    }
  },

  toggleRandomize: function() {
    const container = $('#randomize');
    if ($(this).prop('checked')) {
      container.hide().removeClass('hidden').slideDown(400);
    }
    else {
      container.slideUp(400);
    }
  }
};