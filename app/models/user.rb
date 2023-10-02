class User < ApplicationRecord
  has_secure_token :password_reset_token
  has_secure_password
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :email, :name, :password_digest, :info, presence: true

  # # список всех Тестов, которые проходит или проходил Пользователь на этом уровне
  # # поломалось, TODO: переделать
  # def passed_tests_by_level(level)
  #   passed_tests.by_level(level)
  # end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
