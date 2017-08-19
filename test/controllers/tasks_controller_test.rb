require 'test_helper'

class TasksControlerTest < ActionDispatch::IntegrationTest
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
                                     min_no_random_correct_solutions: 1 } }
    assert Task.find_by(name: 'Apples')
  end
end
