# frozen_string_literal: true

module QuizzesHelper
  def author_alias(item)
    if item.author.last_name.present? && item.author.first_name.present?
      "#{item.author.last_name} #{item.author.first_name[0]}."
    else
      item.author.email.split('@')[0]
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