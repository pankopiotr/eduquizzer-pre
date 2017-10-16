# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :pieces
  attr_accessor :current_step

  def save_score
    update_attribute(:score, count_score)
  end

  def current_step
    @current_step || 0
  end

  def next_step
    self.current_step += 1
  end

  def previous_step
    self.current_step -= 1
  end

  def first_step?
    self.current_step.zero?
  end

  def last_step?
    self.current_step == quiz.tasks.count - 1
  end

  private

    def count_score
      score = 0
      pieces.each do |piece|
        score += piece.task.score if (piece.task.correct_solutions &
                                       piece.randomized_solutions).sort ==
                                      piece.chosen_solutions.sort
      end
      score
    end
end