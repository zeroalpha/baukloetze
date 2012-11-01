module ApplicationHelper
  def print_old_date(date)
    date.day.to_s + ". " + date.strftime("%B")+" of " + date.year.to_s
  end
  def print_date(date)
    date.day.to_s + ". " + date.strftime("%B")+" " + date.year.to_s
  end
end
