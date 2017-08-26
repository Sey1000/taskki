class DuePrettifier
  def prettify_today_due(today_arr)
    today_arr.each do |task|
      due_date = Date.parse(task.due)
      how_many = (due_date - Date.today).to_i
      if how_many > 7
        date = due_date
        task.due = "#{date.strftime("%b")} #{date.strftime("%d")}"        
      elsif how_many == 0
        task.due = "today"
      else
        task.due = "#{how_many} days"
      end
    end
    return today_arr
  end

  def prettify_week_due(week_arr)
    week_arr.each do |task|
      how_many = (Date.parse(task.due) - Date.today).to_i
      task.due = "#{how_many} days"
    end
    return week_arr
  end

  def prettify_longterm_due(longterm_arr)
    longterm_arr.each do |task|
      date = Date.parse(task.due)
      task.due = "#{date.strftime("%b")} #{date.strftime("%d")}"
    end
  end
end