class User < ApplicationRecord
  has_secure_token :password_reset_token
  has_secure_password
end
