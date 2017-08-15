class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    redirect_to root_path
  end
end
