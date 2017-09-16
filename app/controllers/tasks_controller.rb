# frozen_string_literal: true

class TasksController < ApplicationController
  include TaskExtension
  include Session

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.add_author(current_user)
    if @task.save
      flash[:success] = t(:task_created)
      redirect_to new_task_path
    else
      render 'new'
    end
  end
end
