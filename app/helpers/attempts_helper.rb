# frozen_string_literal: true

module AttemptsHelper
  def current_task
    @attempt.quiz.tasks[@attempt.current_step]
  end

  def solution_chosen?(solution, piece)
    piece.chosen_solutions.include?(solution)
  end

  def solution_background(solution, piece)
    if solution_chosen?(solution, piece)
      piece.task.correct_solutions.include?(solution) ? 'bg-success' : 'bg-danger'
    elsif piece.task.correct_solutions.include?(solution)
      'bg-danger'
    end
  end

  def validate_solution(solution, piece)
    bg = solution_background(solution, piece)
    content_tag(:div, class: "form-check #{bg}") do
      check_box('none', { class: 'form-check-input' }, disabled: true,
                checked: (true if solution_chosen?(solution, piece))) +
        label('none', solution, class: 'form-check-label')
    end
  end
end
