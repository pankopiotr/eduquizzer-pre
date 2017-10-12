# frozen_string_literal: true

class Quiz < ApplicationRecord
  attr_accessor :task_list
  has_and_belongs_to_many :tasks
  belongs_to :author, class_name: 'User'
  before_validation :remove_archived_tasks
  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :password, uniqueness: true, presence: true, length: { in: 12..32 }
  validates :task_list, presence: true
  before_save :create_tasks_associations

  def add_author(user)
    self.author = user
  end

  def mark_as_used
    return if used
    update_attribute(:used, true)
    return unless tasks
    tasks.update_all(used: true)
  end

  def archive
    return if archived
    update_attribute(:archived, true)
  end

  private

    def create_tasks_associations
      return unless task_list
      tasks.delete_all
      task_list.each do |task_id|
        tasks << Task.find_by(id: task_id)
      end
    end

    def remove_archived_tasks
      task_list.delete_if { |id| Task.find_by(id: id).archived? }
    end
end
