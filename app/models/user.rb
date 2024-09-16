class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def generate_login_token
    self.login_token = SecureRandom.urlsafe_base64(32)
    self.login_token_valid_until = 30.minutes.from_now
    save!
  end

  def login_token_valid?
    login_token_valid_until.present? && login_token_valid_until > Time.current
  end

  def admin?
    email == "admin@ancient.com"
  end
end
