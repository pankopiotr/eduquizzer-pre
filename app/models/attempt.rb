# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  attr_accessor :current_step

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
    self.current_step == 0
  end

  def last_step?
    self.current_step == quiz.tasks.count - 1
  end
end