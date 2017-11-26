require 'test_helper'

class AttemptsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
    sign_in_as @user
  end

  test 'should get new' do
    post password_check_path, params: { attempt: { password:
                                                       '0123456789xxxxxxxx' } }
    assert_redirected_to quiz_path
  end

  test 'should mark quiz as used' do
    post password_check_path, params: { attempt: { password:
                                                       '0123456789xxxxxxxx' } }
    assert Quiz.find_by(name: 'QuizFix').used
  end

  test 'should mark tasks as used' do
    post password_check_path, params: { attempt: { password:
                                                       '0123456789xxxxxxxx' } }
    Quiz.find_by(name: 'QuizFix').tasks.each do |task|
      assert task.used
    end
  end

  test 'should render new task' do
    post password_check_path, params: { attempt: { password:
                                                       '0123456789xxxxxxxx' } }
    assert_redirected_to quiz_path
    follow_redirect!
    post quiz_path, params: { piece: { chosen_solutions: [] } }
    assert_response :success
  end

  test 'should get summary' do
    post password_check_path, params: { attempt: { password:
                                                       '0123456789xxxxxxxx' } }
    Quiz.find_by(name: 'QuizFix').tasks.each do
      post quiz_path, params: { piece: { chosen_solutions: [] } }
    end
    assert_redirected_to summary_path
  end

  test 'should count score' do
    post password_check_path, params: { attempt: { password:
                                                       '0123456789xxxxxxxx' } }
    Attempt.last.pieces.each do |piece|
      post quiz_path, params: { piece: { chosen_solutions:
                                             piece.randomized_solutions &
                                             piece.task.correct_solutions } }
    end
    assert_equal Attempt.last.pieces.count, Attempt.last.score
  end
end
