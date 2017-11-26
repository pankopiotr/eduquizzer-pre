# frozen_string_literal: true

class AttemptsController < ApplicationController
  skip_before_action :admin_user?
  before_action :find_attempt, :find_piece, only: %i[new create summary]
  before_action :attempt_active?, only: %i[new create]

  def new
    @attempt.current_step = session[:current_step]
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
      create_pieces(Attempt.create(user: current_user, quiz: quiz,
                                   score: -9999))
      redirect_to quiz_path, flash: { success: t(:correct_quiz_password) }
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
      redirect_to interface_path unless @attempt.score == -9999
    end

    def create_pieces(attempt)
      attempt.quiz.tasks.each do |task|
        Piece.create(attempt: attempt, task: task,
                     randomized_solutions: task.randomize_solutions)
      end
    end

    def piece_params
      params.require(:piece).permit(chosen_solutions: [])
    end

    def find_piece
      @piece = @attempt.pieces[@attempt.current_step]
    end
end
