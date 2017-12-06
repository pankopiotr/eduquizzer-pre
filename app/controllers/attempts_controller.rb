# frozen_string_literal: true

class AttemptsController < ApplicationController
  skip_before_action :admin_user?
  before_action :find_attempt, only: %i[new create summary password_check]
  before_action :attempt_active?, only: %i[new create]
  before_action :check_expiration, only: %i[new create password_check]

  def new
    find_piece
  end

  def create
    @attempt.current_step = session[:current_step]
    find_piece
    @piece.update(piece_params) if params[:piece] &&
                                   params[:piece][:chosen_solutions]
    if params[:back_button]
      @attempt.previous_step
    elsif @attempt.last_step?
      @attempt.save_score
      session.delete(:current_step)
      return redirect_to summary_path, flash: { success: 'Finished test' }
    else
      @attempt.next_step
    end
    session[:current_step] = @attempt.current_step
    find_piece
    render 'new'
  end

  def index
    @attempts = if current_user.admin?
                  Attempt.order(created_at: :desc).limit(35)
                else
                  current_user.attempts.order(created_at: :desc).limit(5)
                end
  end

  def password_check
    redirect_to interface_path and return if @attempt&.active?
    quiz = Quiz.find_by(password: params[:attempt][:password])
    if quiz&.active && !quiz.archived?
      quiz.mark_as_used
      Attempt.create(user: current_user, quiz: quiz, score: -9999).create_pieces
      redirect_to attempt_path, flash: { success: t(:correct_quiz_password) }
    else
      redirect_to interface_path, flash: { danger: t(:wrong_quiz_password) }
    end
  end

  def summary
    redirect_to attempt_path if @attempt&.active?
  end

  private

    def find_attempt
      @attempt = current_user.attempts.last
    end

    def attempt_active?
      redirect_to interface_path unless @attempt&.active?
    end

    def check_expiration
      return unless @attempt&.expired? && @attempt.active?
      @attempt.save_score
      session.delete(:current_step)
      redirect_to summary_path, flash: { success: 'Finished test' }
    end

    def piece_params
      params.require(:piece).permit(chosen_solutions: [])
    end

    def find_piece
      @piece = @attempt.pieces.sort[@attempt.current_step]
    end
end
