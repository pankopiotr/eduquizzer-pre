# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :instantiate_task_list

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(test_params)
    @quiz.add_author(current_user)
    if @quiz.save
      redirect_to new_quiz_path, flash: { success: t(:quiz_created) }
    else
      render 'new'
    end
  end

  private

    def test_params
      params.require(:quiz).permit(:name, :password, :random, :no_random_tasks,
                                   :time_limit, task_list: [])
    end

    def instantiate_task_list
      @tasks = Task.all
    end
end
