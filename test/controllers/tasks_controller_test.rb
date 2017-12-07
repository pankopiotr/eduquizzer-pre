# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    sign_in_as@user
    @task = tasks(:taskApples)
  end

  test 'should get new' do
    get new_task_path
    assert_response :success
  end

  test 'should create task' do
    get new_task_path
    post '/tasks', params: { task: { name: 'Apples',
                                     task_type: 'Close-ended',
                                     category: 'test',
                                     description: 'Are apples blue?',
                                     correct_solutions: %w[no nope false],
                                     wrong_solutions: %w[yes definitely],
                                     score: 1, random: true,
                                     no_random_solutions: 4,
                                     min_no_random_correct_solutions: 1 } }
    assert Task.find_by(name: 'Apples')
  end

  test 'should prevent used task edit' do
    get edit_task_path(@task)
    assert_response :success
    @task.update_attribute(:used, true)
    get edit_task_path(@task)
    assert_response :redirect
  end

  test 'should prevent archived task edit' do
    get edit_task_path(@task)
    assert_response :success
    @task.archive
    get edit_task_path(@task)
    assert_response :redirect
  end
end
