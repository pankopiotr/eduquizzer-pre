# frozen_string_literal: true

class Quiz < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :name, :password, :tasks, presence: true
  validates :password, length: { in: 12..32 }

  def add_author(user)
    self.author = user
  end
end
