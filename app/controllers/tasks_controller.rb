class TasksController < ApplicationController
  include TasksHelper

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    flash.now[:success] = t(:task_created) if @task.save
    render 'new'
  end
end
