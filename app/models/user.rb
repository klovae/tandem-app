class User < ApplicationRecord
  has_many :permissions
  has_many :projects, through: :permissions
  has_secure_password

  validates :first_name, :email, :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :email, uniqueness: true

  def full_name
    self.first_name + " " + self.last_name
  end

end
