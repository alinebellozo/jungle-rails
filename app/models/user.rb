class User < ApplicationRecord

  has_secure_password
  
  validates :email, presence: true, uniqueness: { case_sensitive: false, message: "This email address is already registered, please enter a different one" }
  validates :password, presence: true, length: {minimum: 8}
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_validation: :downcase_email

  private

  def downcase_email 
    self.email = email.downcase if email.present?
  end

end
