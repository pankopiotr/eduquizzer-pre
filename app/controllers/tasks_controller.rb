class TasksController < ApplicationController
  include TasksHelper

  def new
    @all_task_types = Task::TASK_TYPES_LIST
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = t(:task_created)
      redirect_to new_task_path
    else
      render 'new'
    end
  end
end
