# frozen_string_literal: true)

require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  def setup
    @attempt = Attempt.new(user: users(:jane), quiz: quizzes(:quizFix),
                           score: -9999, pieces: [pieces(:one), pieces(:two)])
  end

  test 'should validate attempt' do
    assert @attempt.valid?
  end

  test 'should count max score' do
    @attempt.save_score
    assert_equal 2, @attempt.max_score
  end

  test 'should count attempt score' do
    @attempt.save_score
    assert_equal 1, @attempt.score
  end

  test 'should create pieces for attempt' do
    @new_attempt = Attempt.new(user: users(:jane), quiz: quizzes(:quizFix),
                               score: -9999).create_pieces
    assert_equal 2, @new_attempt.pieces.count
  end
end
