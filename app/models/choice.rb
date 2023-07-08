class Choice < ApplicationRecord
  belongs_to :pass
  belongs_to :question
  belongs_to :answer

  validates :pass_id, :question_id, :answer_id, presence: true
end
