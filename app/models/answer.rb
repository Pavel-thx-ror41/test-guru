class Answer < ApplicationRecord
  belongs_to :question

  validates :question_id, :title, :info, presence: true
  validates :correct, inclusion: { in: [false, true] }
  validate :only_4_answers_for_one_test, on: :create

  scope :correct_only, -> { where(correct: true) }

  private

  def only_4_answers_for_one_test
    errors.add(:base, "У одного Вопроса может быть до 4-х ответов") if question.answers.count >= 4
  end
end
