class User < ApplicationRecord
  validates :email,      presence: true, length: { maximum: 64 },
                         uniqueness: { case_sensitive: false }, email: true
  validates :password,   presence: true, length: { in: 8..64 }
  validates :first_name, length: { in: 2..16 }, allow_blank: true
  validates :last_name,  length: { in: 2..32 }, allow_blank: true
  validates :student_id, length: { in: 5..6 }, allow_blank: true,
                         numericality: true
end