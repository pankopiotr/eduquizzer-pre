# frozen_string_literal: true

module QuizzesHelper
  def author_alias(task)
    if task.author.last_name.present? && task.author.first_name.present?
      "#{task.author.last_name} #{task.author.first_name[0]}."
    else
      task.author.email.split('@')[0]
    end
  end

  def show_filter
    params[:controller] == 'quizzes' && (params[:action] == 'new' ||
        params[:action] == 'create')
  end

  def editable?(item)
    !item.used && !item.archived
  end
end