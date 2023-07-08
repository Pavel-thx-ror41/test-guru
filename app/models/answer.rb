class Answer < ApplicationRecord
  belongs_to :question

  validates :question_id, :title, :info, presence: true

  scope :correct_only, -> { where(correct: true) }
end
