module TestPassagesHelper
  def test_passage_status
    @test_passage.success? ? 'test_passed' : 'test_failed'
  end
end
