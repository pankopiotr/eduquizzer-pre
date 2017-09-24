# frozen_string_literal: true

class AttemptsController < ApplicationController
  def new
    @attempt = Attempt.new
  end

  def create
  end
end
