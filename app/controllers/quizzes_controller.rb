# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :instantiate_task_list
  before_action :find_editable_quiz, only: %i[edit update]

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.add_author(current_user)
    if @quiz.save
      redirect_to quizzes_path, flash: { success: t(:quiz_created) }
    else
      render 'new'
    end
  end

  def index
    @quizzes = Quiz.all
  end

  def edit
  end

  def update
    if @quiz.update_attributes(quiz_params)
      redirect_to quizzes_path, flash: { success: t(:quiz_updated) }
    else
      render 'edit'
    end
  end

  private

    def quiz_params
      params.require(:quiz).permit(:name, :password, :random, :no_random_tasks,
                                   :time_limit, task_list: [])
    end

    def instantiate_task_list
      @tasks = Task.all
    end

    def find_editable_quiz
      @quiz = Quiz.find_by(id: params[:id])
      return if editable?(@quiz)
      redirect_to quizzes_path, flash: { danger: t(:cannot_edit_quiz) }
    end
end
