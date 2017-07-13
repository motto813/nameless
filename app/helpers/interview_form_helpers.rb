module InterviewFormHelpers
  def meeting_time_value_format(datetime)
    return "" unless datetime

    datetime.strftime("%Y-%m-%dT%I:%M")
  end
end

helpers InterviewFormHelpers
