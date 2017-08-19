class User < ApplicationRecord
  include UsersHelper
  has_many :tasks
  before_save :encrypt_password
  attr_accessor :remember_token, :updating_password, :password
  validates :email,      presence: true, length: { maximum: 64 },
                         uniqueness: { case_sensitive: false }, email: true
  validates :password,   presence: true, length: { in: 8..64 },
                         if: :should_validate_password?
  validates :first_name, length: { in: 2..16 }, allow_blank: true
  validates :last_name,  length: { in: 2..32 }, allow_blank: true
  validates :student_id, length: { in: 5..6 }, allow_blank: true,
                         numericality: true

  def remember
    self.remember_token = generate_token
    update_attribute(:cookie_digest, digest(remember_token))
  end

  def forget
    update_attribute(:cookie_digest, nil)
  end

  private

    def encrypt_password
      if password.present?
        self.password_digest = BCrypt::Password.create(password)
        self.password = nil
      end
    end

    def should_validate_password?
      updating_password || new_record?
    end
end