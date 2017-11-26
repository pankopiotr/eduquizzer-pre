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
    params[:controller] == 'quizzes' &&
      %w[new create edit update].include?(params[:action])
  end
end