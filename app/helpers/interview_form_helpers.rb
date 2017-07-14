module InterviewFormHelpers
  def meeting_time_value_format(datetime)
    return "" unless datetime

    datetime.strftime("%Y-%m-%dT%I:%M")
  end

  def date_and_time(datetime)
    datetime.strftime("%A %B %e, %Y at %l:%M %P")
  end
end

helpers InterviewFormHelpers
