# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :pieces
  attr_accessor :current_step

  def save_score
    score = 0
    max_score = 0
    pieces.each do |piece|
      score += piece.task.score if (piece.task.correct_solutions &
          ApplicationController.helpers.get_solutions(piece)).sort ==
                                    piece.chosen_solutions.sort
      max_score += piece.task.score
    end
    update_attribute(:score, score)
    update_attribute(:max_score, max_score)
  end

  def expired?
    created_at + quiz.time_limit.minutes < Time.now
  end

  def create_pieces
    quiz.tasks.each do |task|
      Piece.create(attempt: self, task: task,
                   randomized_solutions: task.randomize_solutions)
    end
  end

  def active?
    score == -9999
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
end