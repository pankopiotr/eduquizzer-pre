# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  include GenerateDigest
  # Preview this email at http://0.0.0.0:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.last
    user.activation_token = generate_token
    UserMailer.account_activation(user)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = generate_token
    UserMailer.password_reset(user)
  end
end