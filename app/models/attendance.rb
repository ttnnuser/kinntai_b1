class Attendance < ApplicationRecord
  belongs_to :user
  validates :worked_on, presence: true
  before_save :started_at_should_present
  validate :started_at_should_early_than_finished_at
  private
  
    def started_at_should_present
      errors.add(:finished_at, ": 出勤時間が打刻されていません。") if self.started_at.nil?
    end
    def started_at_should_early_than_finished_at
      if started_at && working_times(started_at, finished_at).to_i < 0
        errors.add(:finished_at, ": 退勤時間が正しくありません。")
      end
    end
    def working_times(started_at, finished_at)
        format("%.2f", (((finished_at.round_to(15) - started_at.round_to(15)) / 60) /60.0 )) if finished_at
    end
end
