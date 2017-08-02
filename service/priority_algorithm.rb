# service class
require 'date'

class PriorityAlgorithm
  attr_reader :today, :week, :longterm
  def initialize(tasks_arr)
    @tasks = tasks_arr.sort_by {|ins| ins.due}
    @today = []
    @week = []
    @longterm = []
    load_tasks
    order_today
    # numbering and prettify should always be at the end
    numbering
    prettify_due
  end

  private

  def numbering
    @today.each_with_index do |task, ind|
      task.numbering = ind + 1
    end
    @week.each_with_index do |task, ind|
      task.numbering = ind + 1 + @today.length
    end
    @longterm.each_with_index do |task, ind|
      task.numbering = ind + 1 + @today.length + @week.length
    end
  end

  def prettify_due
    @today.each do |task|
      how_many = (Date.parse(task.due) - Date.today).to_i
      if how_many > 7
        date = Date.parse(task.due)
        task.due = "#{date.strftime("%b")} #{date.strftime("%d")}"        
      elsif how_many == 0
        task.due = "today"
      else
        task.due = "#{how_many} days"
      end
    end
    @week.each do |task|
      how_many = (Date.parse(task.due) - Date.today).to_i
      task.due = "#{how_many} days"
    end
    @longterm.each do |task|
      date = Date.parse(task.due)
      task.due = "#{date.strftime("%b")} #{date.strftime("%d")}"
    end
  end

  def order_today
    prs = @today.select { |task| task.top_priority }
    rest = @today.reject { |task| task.top_priority }
    prs.sort_by {|task| (Date.parse(task.due) - Date.today).to_i}
    @today = prs + rest
  end

  def load_tasks
    @tasks.each do |task|
      diff = (Date.parse(task.due) - Date.today).to_i
      if diff <= task.takes || diff == 0
        @today << task
      elsif task.top_priority
        @today << task
      elsif diff < 7
        @week << task
      else
        @longterm << task
      end
    end
  end
end

# a = Date.parse('Aug 1')
# p a == Date.today