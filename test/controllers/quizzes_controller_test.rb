# frozen_string_literal: true

require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_quiz_path
    # assert_response :success
  end

end
