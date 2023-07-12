class Pass < ApplicationRecord
  belongs_to :user
  belongs_to :test

  validates :user_id, :test_id, :pass_start, presence: true
end
