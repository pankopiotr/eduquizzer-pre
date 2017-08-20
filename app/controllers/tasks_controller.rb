# frozen_string_literal: true

class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = helpers.current_user.id
    if @task.save
      flash[:success] = t(:task_created)
      redirect_to new_task_path
    else
      render 'new'
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
end
