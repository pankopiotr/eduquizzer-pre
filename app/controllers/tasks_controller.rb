# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[edit update archive]
  before_action :task_editable?, only: %i[edit update]
  before_action :task_archivable?, only: :archive

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.add_author(current_user)
    if @task.save
      redirect_to tasks_path, flash: { success: t(:task_created) }
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
      redirect_to tasks_path, flash: { success: t(:task_updated) }
    else
      render 'edit'
    end
  end

  def archive
    @task.archive
    redirect_to tasks_path, flash: { success: t(:task_archived) }
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
      return if (@task = Task.find_by(id: params[:id]))
      redirect_to tasks_path, flash: { danger: t(:cannot_find_task) }
    end

    def task_editable?
      return if editable?(@task)
      redirect_to tasks_path, flash: { danger: t(:cannot_edit_task) }
    end

    def task_archivable?
      return unless @task.archived
      redirect_to tasks_path, flash: { danger: t(:cannot_archive_task) }
    end

end
