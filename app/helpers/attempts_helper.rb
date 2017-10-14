# frozen_string_literal: true

module AttemptsHelper
  def current_task
    @attempt.quiz.tasks[@attempt.current_step]
  end
end