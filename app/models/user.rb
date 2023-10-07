class User < ApplicationRecord
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authored_tests, class_name: 'Test', foreign_key: :user_id

  has_secure_password
  validates :password, presence: true, if: Proc.new { |u| u.password_digest.blank? }
  validates :password, confirmation: true
  validates :email, presence: true, uniqueness: { message: 'уже используется другим пользователем' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'неверный формат адреса' }
  before_validation :normalize_email

  def normalize_email
    self.email = email.downcase.strip
  end

  # # список всех Тестов, которые проходит или проходил Пользователь на этом уровне
  # # поломалось, TODO: переделать
  # def passed_tests_by_level(level)
  #   passed_tests.by_level(level)
  # end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
