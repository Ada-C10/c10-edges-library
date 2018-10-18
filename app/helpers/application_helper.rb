module ApplicationHelper
  def readable_date(date)
    return "[unknown]" if date.nil?
    return [
      "<span class='date' title='#{date}'>",
      time_ago_in_words(date),
      " ago",
      "</span>"
    ].join.html_safe
  end
end
