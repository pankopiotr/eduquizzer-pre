$(function() {
  $('.filter-box').css({'flex-grow': '0', 'padding-left': 0, 'padding-right': 0});
  const savedTasks = $('#saved-tasks').data('saved-tasks');
  if (typeof savedTasks !== 'undefined') {
    $.each(savedTasks, function(key, value) {
      filterTasks(value);
    });
  }
});

$(document).on('turbolinks:load', function() {
  if ($('#randomize_quiz').prop('checked')) {
    const container = $('#randomize');
    container.removeClass('hidden');
  }

  $('#randomize_quiz').change( function() {
    const container = $('#randomize');
    if ($(this).prop('checked')) {
      container.hide().removeClass('hidden').slideDown(400);
    }
    else {
      container.slideUp(400);
    }
  });

  function generateQuizPassword() {
    return (Math.random() + Math.random() * Math.pow(10,24)).toString(36);
  }

  $('#generate_password').on('click', function() {
    $('input#quiz_password').val(generateQuizPassword());
  });

  $('table').on('click','.add-task', moveToChosenTable);

  function moveToChosenTable() {
    const removeTranslated = $('#remove_translated').data('remove');
    $(this).removeClass('add-task').empty().addClass('remove-task');
    const row = $(this).closest('tr').clone();
    $(this).closest('tr').remove();
    row.appendTo('#chosen-tasks');
    const content = $('<div><div>').addClass('btn btn-danger btn-xs').text(removeTranslated);
    const id = row.children().first().text();
    const accordion = $('#accordion'+ id).closest('tr');
    const hiddenInput = $('<input name="quiz[tasks][]" disabled>').addClass('hidden form-control').val(id);
    hiddenInput.appendTo(content);
    content.appendTo($('.remove-task').last());
    accordion.appendTo($('#chosen-tasks').last());
  }

  $('table').on('click','.remove-task', moveToAllTable);

  function moveToAllTable() {
    const addTranslated = $('#add_translated').data('add');
    $(this).removeClass('remove-task').empty().addClass('add-task');
    const row = $(this).closest('tr').clone();
    $(this).closest('tr').remove();
    row.appendTo('#all-tasks');
    const content = $('<div><div>').addClass('btn btn-primary btn-xs').text(addTranslated);
    const id = row.children().first().text();
    const accordionNew = $('#accordion'+ id).closest('tr').clone();
    $('#accordion'+ id).closest('tr').remove();
    content.appendTo($('.add-task').last());
    accordionNew.appendTo($('#all-tasks').last());
  }

  function toggleFilter() {
    const box = $('.filter-box');
    if (box.css('flex-grow') == 0) {
      box.animate({'flex-grow': 1, 'padding-left': 12, 'padding-right': 12}, 180);
    }
    if (box.css('flex-grow') == 1) {
      box.animate({'flex-grow': 0.01, 'padding-left': 0, 'padding-right': 0}, 180, function() {
        box.css('flex-grow', '0');
      });
    }
  }

  $('.filter-bookmark').on('click', toggleFilter);

  /* This code is fucking ridiculous. Refactor it. */
  function filterTasks(idFilter) {
    let $rows = $('#all-tasks tr, #chosen-tasks tr');
    if (!$('#filterQuizTasks').prop('checked')) {
      $rows.show();
      $rows = $('#all-tasks tr');
    }
    if (typeof idFilter !== 'number') {idFilter = $.trim($('input[name="filter[id]"]').val()).replace(/ +/g, ' ').toLowerCase();}
    const nameFilter = $.trim($('input[name="filter[name]"]').val()).replace(/ +/g, ' ').toLowerCase();
    const authorFilter = $.trim($('input[name="filter[author]"]').val()).replace(/ +/g, ' ').toLowerCase();
    const categoryFilter = $.trim($('input[name="filter[category]"]').val()).replace(/ +/g, ' ').toLowerCase();
    const scoreFilter = $.trim($('input[name="filter[score]"]').val()).replace(/ +/g, ' ').toLowerCase();

    $rows.show().filter(function() {
      const idText = $(this).find($('.id')).text().replace(/\s+/g, ' ').toLowerCase();
      const nameText = $(this).find($('.name')).text().replace(/\s+/g, ' ').toLowerCase();
      const authorText = $(this).find($('.author')).text().replace(/\s+/g, ' ').toLowerCase();
      const categoryText = $(this).find($('.category')).text().replace(/\s+/g, ' ').toLowerCase();
      const scoreText = $(this).find($('.score')).text().replace(/\s+/g, ' ').toLowerCase();
      return !~idText.indexOf(idFilter) || !~nameText.indexOf(nameFilter) || !~authorText.indexOf(authorFilter)
             || !~categoryText.indexOf(categoryFilter) || !~scoreText.indexOf(scoreFilter);
    }).hide();
  }

  $('.filter-button').on('click', filterTasks);

  function clearFilters() {
    $('input[name="filter[id]"]').val('');
    $('input[name="filter[name]"]').val('');
    $('input[name="filter[author]"]').val('');
    $('input[name="filter[category]"]').val('');
    $('input[name="filter[score]"]').val('');
    $('#all-tasks tr, #chosen-tasks tr').show();
  }

  $('.filter-clear').on('click', clearFilters);
});