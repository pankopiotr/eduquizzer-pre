# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    sign_in_as@user
  end

  test 'should get new' do
    get new_task_path
    assert_response :success
  end

  test 'should create task' do
    get new_task_path
    post '/tasks', params: { task: { name: 'Apples',
                                     task_type: 'close-ended',
                                     category: 'test',
                                     description: 'Are apples blue?',
                                     correct_solutions: %w[no nope false],
                                     wrong_solutions: %w[yes definitely],
                                     score: 1, mathjax: false, random: true,
                                     no_random_solutions: 4,
                                     min_no_random_correct_solutions: 1,
                                     user_id: 1 } }
    assert Task.find_by(name: 'Apples')
  end
end
