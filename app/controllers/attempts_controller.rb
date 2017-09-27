# frozen_string_literal: true

class AttemptsController < ApplicationController
  skip_before_action :admin_user?
  before_action :find_attempt

  def new
  end

  def create
  end

  def index
    @attempts = Attempt.all
  end

  def password_check
    if (quiz = Quiz.find_by(password: params[:attempt][:password]))
      @attempt = Attempt.create(user: current_user, quiz: quiz, score: -9999)
      redirect_to new_attempt_path, flash: { success: t(:correct_quiz_password) }
    else
      redirect_to interface_path, flash: { danger: t(:wrong_quiz_password) }
    end
  end

  private

    def find_attempt
      @attempt = current_user.attempts.last
    end
end
