class RemoveNotNullFromMeetingTime < ActiveRecord::Migration
  def change
    change_column_null :interviews, :meeting_time, true
  end
end
