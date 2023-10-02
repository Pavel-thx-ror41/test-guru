module TestPassagesHelper
  def test_passage_status
    @test_passage.success? ? 'passed' : 'failed'
  end
end
