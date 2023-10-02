class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_create :before_create_set_current_question_first
  before_update :before_update_set_current_question_next

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  private

  def before_create_set_current_question_first
    self.current_question = self.test.questions.first if test.present?
  end

  def before_update_set_current_question_next
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    return true if correct_answers.ids.empty? && answer_ids.nil?

    correct_answers.ids.sort == answer_ids.map(&:to_i).sort if answer_ids
  end

  def correct_answers
    current_question.answers.correct_only
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
