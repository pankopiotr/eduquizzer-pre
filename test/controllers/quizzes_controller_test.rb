# frozen_string_literal: true

require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    sign_in_as@user
    @quiz = quizzes(:quizFix)
  end

  test 'should get new' do
    get new_quiz_path
    assert_response :success
  end

  test 'should create quiz' do
    get new_quiz_path
    post '/quizzes', params: { quiz: { name: 'TestQuiz',
                                       password: 'Password1234',
                                       task_list: [1, 2], time_limit: 15,
                                       random: true, no_random_tasks: 1 } }
    assert Quiz.find_by(name: 'TestQuiz')
  end

  test 'should prevent used quiz edit' do
    get edit_quiz_path(@quiz)
    assert_response :success
    @quiz.mark_as_used
    get edit_quiz_path(@quiz)
    assert_response :redirect
  end

  test 'should prevent archived quiz edit' do
    get edit_quiz_path(@quiz)
    assert_response :success
    @quiz.archive
    get edit_quiz_path(@quiz)
    assert_response :redirect
  end
end
