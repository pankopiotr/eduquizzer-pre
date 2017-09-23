# frozen_string_literal: true

require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @tasks = [tasks(:task1), tasks(:task2)]
    @quiz = Quiz.new(name: 'TestTask', password: '0123456789abcdef',
                     tasks: @tasks, random: true, no_random_tasks: 1,
                     time_limit: 15, author: @user)
  end

  test 'should validate quiz' do
    assert @quiz.valid?
  end

  test 'should not validate empty task list' do
    @quiz.tasks = []
    refute @quiz.valid?
  end

  test 'should not validate empty name' do
    @quiz.name = ''
    refute @quiz.valid?
  end

  test 'should not validate password shorter then 12 digits' do
    @quiz.password = 'a' * 11
    refute @quiz.valid?
  end
end
