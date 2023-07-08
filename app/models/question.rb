class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :test_id, :title, :info, presence: true
end
