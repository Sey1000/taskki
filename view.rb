require 'date'

class View
  def view_today(tasks)
    puts ""
    puts "== TODAY =="
    tasks.each do |task|
      top = task.top_priority ? "[!] " : ""
      puts "#{task.numbering} - #{top}#{task.title} (#{task.due})"
    end
  end

  def view_week(tasks)
    puts ""
    puts "== THIS WEEK =="
    tasks.each do |task|
      puts "#{task.numbering} - #{task.title} (#{task.due})"
    end
  end

  def view_longterm(tasks)
    puts ""
    puts "== LONG TERM =="
    tasks.each do |task|
      puts "#{task.numbering} - #{task.title} (#{task.due})"
    end
  end
end