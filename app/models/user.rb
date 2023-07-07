class User < ApplicationRecord
  has_secure_token :password_reset_token
  has_secure_password
  has_many :passes
  has_many :tests
  has_many :passed_tests, source: :test, through: :passes

  # список всех Тестов, которые проходит или проходил Пользователь на этом уровне
  def passed_tests_by_level(level)
    passed_tests.by_level(level)
  end
end
