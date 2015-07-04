module ApplicationHelper

  def get_next_dayname
    (Date.today+1).strftime("%A").downcase
  end

  def get_previous_dayname
    (Date.today-1).strftime("%A").downcase
  end

  def date_format_view(date)
    date.strftime('%d-%m-%Y')
  end

end
