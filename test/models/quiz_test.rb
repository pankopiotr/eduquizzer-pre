# frozen_string_literal: true

require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @tasks = [tasks(:taskApples), tasks(:taskOranges)]
    @quiz = Quiz.new(name: 'TestTask', password: '0123456789abcdef',
                     task_list: [1, 2], random: true, no_random_tasks: 1,
                     time_limit: 15, author: @user)
  end

  test 'should validate quiz' do
    assert @quiz.valid?
  end

  test 'should not validate empty task list' do
    @quiz.task_list = []
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

  test 'should create valid association with quiz' do
    @quiz.save
    assert_equal 2, Quiz.find_by(name: 'TestTask').tasks.count
  end

  test 'should not validate duplicated name' do
    @dup_quiz_name = Quiz.new(name: 'TestTask', password: 'different_password',
                              task_list: [1, 2], random: true,
                              no_random_tasks: 1, time_limit: 15, author: @user)
    @quiz.save
    refute @dup_quiz_name.valid?
  end

  test 'should not validate duplicated password' do
    @dup_quiz_password = Quiz.new(name: 'Different name',
                                  password: '0123456789abcdef',
                                  task_list: [1, 2], random: true,
                                  no_random_tasks: 1, time_limit: 15,
                                  author: @user)
    @quiz.save
    refute @dup_quiz_password.valid?
  end

  test 'should drop archived tasks' do
    @tasks.first.archive
    @quiz.save
    assert_equal 1, @quiz.tasks.count
  end
end
