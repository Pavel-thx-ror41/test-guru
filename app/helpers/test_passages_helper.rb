module TestPassagesHelper
  def passage_questions_total
    @test_passage.test.questions.count
  end

  def passage_questions_correct
    @test_passage.correct_questions
  end

  def passage_questions_correct_percentage
    (100.0 / passage_questions_total.to_f * passage_questions_correct.to_f).round(2)
  end

  def passage_questions_correct_answers_count_status
    passage_questions_correct_percentage >= 85 ? 'passed' : 'failed'
  end
end
