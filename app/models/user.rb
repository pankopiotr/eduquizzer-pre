# frozen_string_literal: true

class User < ApplicationRecord
  include GenerateDigest
  has_many :tasks
  attr_accessor :remember_token, :updating_password, :password, :activation_token
  validates :email,      presence: true, length: { maximum: 64 },
                         uniqueness: { case_sensitive: false }, email: true
  validates :password,   presence: true, length: { in: 8..64 },
                         if: :should_validate_password?
  validates :first_name, length: { in: 2..16 }, allow_blank: true
  validates :last_name,  length: { in: 2..32 }, allow_blank: true
  validates :student_id, length: { in: 5..6 }, allow_blank: true,
                         numericality: true
  before_save :encrypt_password
  before_create :create_activation_digest, :downcase_email

  def remember
    self.remember_token = generate_token
    update_attribute(:cookie_digest, digest(remember_token))
  end

  def forget
    update_attribute(:cookie_digest, nil)
  end

  def authenticated?(remember_token)
    return false if cookie_digest.nil?
    BCrypt::Password.new(cookie_digest).is_password?(remember_token)
  end

  def activate
    update_attribute(:activated, true)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

    def encrypt_password
      return unless password.present?
      self.password_digest = BCrypt::Password.create(password)
      self.password = nil
    end

    def should_validate_password?
      updating_password || new_record?
    end

    def create_activation_digest
      self.activation_token  = generate_token
      self.activation_digest = digest(activation_token)
    end

    def downcase_email
      self.email = email.downcase
    end
end