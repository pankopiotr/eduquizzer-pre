class TasksController < ApplicationController
  include TasksHelper

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
end
