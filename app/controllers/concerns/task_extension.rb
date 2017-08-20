# frozen_string_literal: true

module TaskExtension
  extend ActiveSupport::Concern

  private

    def task_params
      params.require(:task).permit(:name, :task_type, :category, :description,
                                   :asset, :score, :mathjax, :random,
                                   :no_random_solutions,
                                   :min_no_random_correct_solutions,
                                   correct_solutions: [], wrong_solutions: [])
    end
end