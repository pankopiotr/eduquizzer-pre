$(function() {
  quiz.initialize();
});

quiz = {
  tableHeaders: ['id', 'name', 'author', 'category', 'score'],

  cleanFilterInput: function(value) {
    return $.trim($('input[name="filter[' + value + ']"]').val()).replace(/ +/g, ' ').toLowerCase();
  },

  clearFilterInput: function(value) {
    $('input[name="filter[' + value + ']"]').val('');
  },

  clearFilters: function() {
    quiz.tableHeaders.forEach(quiz.clearFilterInput);
    $('tr').show();
  },
  
  filterTasks: function(idFilter) {
    const nameFilter = quiz.cleanFilterInput('name');
    const authorFilter = quiz.cleanFilterInput('author');
    const categoryFilter = quiz.cleanFilterInput('category');
    const scoreFilter = quiz.cleanFilterInput('score');
    let $rows = $('tr');
    if (!$('#filterQuizTasks').prop('checked')) {
      $rows.show();
      $rows = $('#all-tasks').children('tr');
    }
    if (typeof idFilter !== 'number') {
      idFilter = quiz.cleanFilterInput('id');
    }

    $rows.show().filter(function() {
      const $element = $(this);
      const idText = quiz.findColumn($element, 'id');
      const nameText = quiz.findColumn($element, 'name');
      const authorText = quiz.findColumn($element, 'author');
      const categoryText = quiz.findColumn($element, 'category');
      const scoreText = quiz.findColumn($element, 'score');
      return !~idText.indexOf(idFilter)
               || !~nameText.indexOf(nameFilter)
               || !~authorText.indexOf(authorFilter)
               || !~categoryText.indexOf(categoryFilter)
               || !~scoreText.indexOf(scoreFilter);
    }).hide();
  },

  findColumn: function(element, column) {
    return element.find($('.' + column)).text().replace(/\s+/g, ' ').toLowerCase();
  },

  generatePassword: function() {
    return (Math.random() + Math.random() * Math.pow(10,24)).toString(36);
  },

  initialize: function() {
    const numberOfVisibleRows = 8;
    const savedTasks = $('#saved-tasks').data('saved-tasks');
    const tableHeight = $('tr').height() * numberOfVisibleRows;

    // Hide filter menu
    $('.filter-box').css({'flex-grow': '0', 'padding-left': 0, 'padding-right': 0});
    // Remember chosen tasks on validation error
    if (typeof savedTasks !== 'undefined') {
      $.each(savedTasks, quiz.moveToChosenTasksTable);
    }
    // Remember check on validation error
    if ($('#randomize_quiz').prop('checked')) {
      const container = $('#randomize');
      container.removeClass('hidden');
    }
    // Set height depending on initial device height
    $('.table-limit').css('max-height', tableHeight);
    quiz.setEventListeners();
  },

  moveToAllTasksTable: function() {
    const addTranslated = $('#add_translated').data('add');
    $(this).removeClass('remove-task').empty().addClass('add-task');
    const row = $(this).closest('tr').clone();
    $(this).closest('tr').remove();
    row.appendTo('#all-tasks');
    const content = $('<div><div>').addClass('btn btn-primary btn-xs').text(addTranslated);
    const id = row.children().first().text();
    const $accordion = $('#accordion'+ id);
    const accordionNew = $accordion.closest('tr').clone();
    $accordion.closest('tr').remove();
    content.appendTo($('.add-task').last());
    accordionNew.appendTo($('#all-tasks').last());
  },

  moveToChosenTasksTable: function() {
    const removeTranslated = $('#remove_translated').data('remove');
    $(this).removeClass('add-task').empty().addClass('remove-task');
    const row = $(this).closest('tr').clone();
    $(this).closest('tr').remove();
    row.appendTo('#chosen-tasks');
    const content = $('<div><div>').addClass('btn btn-danger btn-xs').text(removeTranslated);
    const id = row.children().first().text();
    const $accordion = $('#accordion'+ id).closest('tr');
    const hiddenInput = $('<input name="quiz[task_list][]">').addClass('hidden form-control').val(id);
    hiddenInput.appendTo(content);
    content.appendTo($('.remove-task').last());
    $accordion.appendTo($('#chosen-tasks').last());
  },

  setEventListeners: function() {
    const $table = $('table');

    $('#randomize_quiz').on('change', function() {
      const container = $('#randomize');
      if ($(this).prop('checked')) {
        container.hide().removeClass('hidden').slideDown(400);
      }
      else {
        container.slideUp(400);
      }
    });

    $('#generate_password').on('click', function() {
      $('input#quiz_password').val(quiz.generatePassword());
    });

    $table.on('click','.add-task', quiz.moveToChosenTasksTable);
    $table.on('click','.remove-task', quiz.moveToAllTasksTable);

    $('.filter-bookmark').on('click', quiz.toggleFilter);
    $('.filter-button').on('click', quiz.filterTasks);
    $('.filter-clear').on('click', quiz.clearFilters);
  },

  toggleFilter: function() {
    const box = $('.filter-box');
    const boxFlexGrow = Number(box.css('flex-grow'));
    if (boxFlexGrow === 0) {
      box.animate({'flex-grow': 1, 'padding-left': 12, 'padding-right': 12}, 180);
    } else if (boxFlexGrow === 1) {
      box.animate({'flex-grow': 0.01, 'padding-left': 0, 'padding-right': 0}, 180, function() {
        box.css('flex-grow', '0');
      });
    }
  }
};