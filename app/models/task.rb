# frozen_string_literal: true

class Task < ApplicationRecord
  TASK_TYPES_LIST = %w[Close-ended Semi-open].freeze
  belongs_to :user
  before_validation :clean_random_options
  validates :name, uniqueness: true
  validates :task_type, :score, :name, :user_id, presence: true
  validate :present_solutions, :random_solutions_check,
           :correct_random_solutions_check

  private

    def all_solutions
      correct_solutions + wrong_solutions
    end

    def random_solutions_check
      return unless no_random_solutions.present?
      if no_random_solutions < 1
        errors.add(:no_random_solutions,
                   :must_be_at_least_one)
      elsif no_random_solutions > all_solutions.count
        errors.add(:no_random_solutions,
                   :cannot_exceed_number_of_all_solutions)
      end
    end

    def correct_random_solutions_check
      return unless min_no_random_correct_solutions.present?
      if min_no_random_correct_solutions.negative?
        errors.add(:min_no_random_correct_solutions,
                   :must_be_positive)
      elsif min_no_random_correct_solutions > correct_solutions.count
        errors.add(:min_no_random_correct_solutions,
                   :cannot_exceed_number_of_correct_solutions)
      end
    end

    def clean_random_options
      return if random
      self.no_random_solutions = nil
      self.min_no_random_correct_solutions = nil
    end

    def present_solutions
      return unless correct_solutions.blank? && wrong_solutions.blank?
      errors.add(:correct_solutions, :solution_must_be_present)
    end
end
