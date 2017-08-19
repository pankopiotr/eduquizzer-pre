class Task < ApplicationRecord
  before_validation :clean_random_options
  validates :name, uniqueness: true
  validates :task_type, :score, :name, presence: true
  validate :present_solutions, :positive_no_random_solutions,
           :no_solutions_le_max, :positive_min_correct_random_solutions,
           :min_correct_random_solutions_le_max

  def all_solutions
    correct_solutions + wrong_solutions
  end

  private

    def positive_no_random_solutions
      if no_random_solutions.present?
        unless no_random_solutions >= 1
          errors.add(:no_random_solutions,
                     :must_be_at_least_one)
        end
      end
    end

    def no_solutions_le_max
      if no_random_solutions.present?
        unless no_random_solutions <= all_solutions.count
          errors.add(:no_random_solutions,
                     :cannot_exceed_number_of_all_solutions)
        end
      end
    end

    def positive_min_correct_random_solutions
      if min_no_random_correct_solutions.present?
        unless min_no_random_correct_solutions >= 0
          errors.add(:min_no_random_correct_solutions,
                     :must_be_positive)
        end
      end
    end

    def min_correct_random_solutions_le_max
      if min_no_random_correct_solutions.present?
        unless min_no_random_correct_solutions <= correct_solutions.count
          errors.add(:min_no_random_correct_solutions,
                     :cannot_exceed_number_of_correct_solutions)
        end
      end
    end

    def clean_random_options
      unless random
        self.no_random_solutions = nil
        self.min_no_random_correct_solutions = nil
      end
    end

    def present_solutions
      errors.add(:correct_solutions, :solution_must_be_present) if correct_solutions.blank? && wrong_solutions.blank?
    end
end
