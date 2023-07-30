class ResetAllTestsCacheCounters < ActiveRecord::Migration[6.1]
  def change
    Test.all.each do |t|
      Test.reset_counters(t.id, :questions)
    end
  end
end
