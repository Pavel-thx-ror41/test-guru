class TestPassage < ApplicationRecord
  PASS_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_save :set_current_question

  def completed?
    current_question.nil?
  end

  def correct_percentage
    (100.0 / test.questions.count.to_f * correct_questions.to_f).round(2)
  end

  def success?
    correct_percentage >= PASS_PERCENT
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def title
    test.title
  end

  private

  def set_current_question
    self.current_question = if current_question.nil?
                              self.test.questions.order(:id).first
                            else
                              next_question
                            end
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
