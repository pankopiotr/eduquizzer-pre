# frozen_string_literal: true

class AttemptsController < ApplicationController
  skip_before_action :admin_user?
  before_action :find_attempt, only: %i[new create summary]
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
    @attempts = Attempt.all
  end

  def password_check
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
  end

  private

    def find_attempt
      @attempt = current_user.attempts.last
    end

    def attempt_active?
      redirect_to interface_path unless @attempt.active?
    end

    def check_expiration
      return unless @attempt&.expired?
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
