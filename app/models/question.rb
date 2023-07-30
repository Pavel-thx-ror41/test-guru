class Question < ApplicationRecord
  belongs_to :test, counter_cache: true
  has_many :answers, dependent: :destroy

  validates :test_id, :title, :info, presence: true
end
