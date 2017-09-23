# frozen_string_literal: true

require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @tasks = [tasks(:taskApples), tasks(:taskOranges)]
    sign_in_as@user
  end

  test 'should get new' do
    get new_quiz_path
    assert_response :success
  end

  test 'should create quiz' do
    get new_quiz_path
    post '/quizzes', params: { quiz: { name: 'TestQuiz',
                                       password: 'Password1234',
                                       tasks: @tasks, time_limit: 15,
                                       random: true, no_random_tasks: 1 } }
    assert Quiz.find_by(name: 'TestQuiz')
  end

end
