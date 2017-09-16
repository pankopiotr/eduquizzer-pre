# frozen_string_literal: true

class Task < ApplicationRecord
  TASK_TYPES_LIST = %w[Close-ended Semi-open].freeze
  belongs_to :author, class_name: 'User'
  before_validation :clean_random_options
  before_save :drop_empty_solutions
  validates :name, uniqueness: true
  validates :task_type, :score, :name, :author_id, presence: true
  validate :present_solutions, :random_solutions_check,
           :correct_random_solutions_check, :correct_task_type
  mount_uploader :asset, AssetUploader

  def add_author(user)
    self.author = user
  end

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

    def correct_task_type
      return if TASK_TYPES_LIST.include? task_type
      errors.add(:task_type, :invalid_task_type)
    end

    def drop_empty_solutions
      correct_solutions.delete_if(&:blank?)
      wrong_solutions.delete_if(&:blank?)
    end
end
