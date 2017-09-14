# frozen_string_literal: true

class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
    @tasks = Task.all
  end

  def create
  end
end
