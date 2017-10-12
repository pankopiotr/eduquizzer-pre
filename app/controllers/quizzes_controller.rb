# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :instantiate_task_list
  before_action :find_quiz, only: %i[edit update archive]
  before_action :quiz_editable?, only: %i[edit update]
  before_action :quiz_archivable?, only: :archive

  def new
    @quiz = Quiz.new
    @tasks = Task.where(archived: false)
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
    @tasks = Task.where(archived: false)
  end

  def update
    if @quiz.update_attributes(quiz_params)
      redirect_to quizzes_path, flash: { success: t(:quiz_updated) }
    else
      render 'edit'
    end
  end

  def archive
    @quiz.archive
    redirect_to quizzes_path, flash: { success: t(:quiz_archived) }
  end

  private

    def quiz_params
      params.require(:quiz).permit(:name, :password, :random, :no_random_tasks,
                                   :time_limit, task_list: [])
    end

    def instantiate_task_list
      @tasks = Task.all
    end

    def find_quiz
      return if (@quiz = Quiz.find_by(id: params[:id]))
      redirect_to quizzes_path, flash: { danger: t(:cannot_find_quiz) }
    end

    def quiz_editable?
      return if editable?(@quiz)
      redirect_to quizzes_path, flash: { danger: t(:cannot_edit_quiz) }
    end

    def quiz_archivable?
      return unless @quiz.archived
      redirect_to quizzes_path, flash: { danger: t(:cannot_archive_quiz) }
    end
end
