ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::RubyMineReporter.new

class ActiveSupport::TestCase
  fixtures :all

  def sign_in_as(user)
    post '/signin', params: { session: { email: user.email,
                                         password: user.password } }
  end

  def sign_out
    get '/signout'
  end

  def in_session?
    !session[:user_id].nil?
  end

  def current_url
    request.original_url
  end
end
