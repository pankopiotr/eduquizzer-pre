# frozen_string_literal: true

module QuizzesHelper
  def author_alias(task)
    if task.author.last_name.present? && task.author.first_name.present?
      "#{task.author.last_name} #{task.author.first_name}."
    else
      task.author.email.split('@')[0]
    end
  end
end