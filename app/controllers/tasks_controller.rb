# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[edit update]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.add_author(current_user)
    if @task.save
      redirect_to new_task_path, flash: { success: t(:task_created) }
    else
      render 'new'
    end
  end

  def index
    @tasks = Task.all
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to new_quiz_path, flash: { success: t(:task_updated) }
    else
      render 'edit'
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :task_type, :category, :description,
                                   :asset, :score, :mathjax, :random,
                                   :no_random_solutions,
                                   :min_no_random_correct_solutions,
                                   correct_solutions: [], wrong_solutions: [])
    end

    def find_task
      @task = Task.find_by(id: params[:id])
    end
end
