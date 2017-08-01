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
  end

  private

  def load_tasks
    @tasks.each do |task|
      diff = Date.parse(task.due) - Date.today
      if task.top_priority || diff == 0
        @today << task
      elsif diff < 7
        @week << task
      else
        @longterm << task
      end
    end
  end

  def load_today
    result = []
    @tasks.each_with_index do |task, ind|
      next unless Date.parse(task.due) - Date.today == 0
      result << [task, ind+1]
    end
    return result
  end

  def load_week
    result = []
    @tasks.each_with_index do |task, ind|
      diff = Date.parse(task.due) - Date.today
      next unless diff > 0 && diff < 7
      result << [task, ind+1]
    end
    return result
  end

  def load_longterm
    result = []
    @tasks.each_with_index do |task, ind|
      diff = Date.parse(task.due) - Date.today
      next unless diff >= 7
      result << [task, ind+1]
    end
    return result
  end
end

# a = Date.parse('Aug 1')
# p a == Date.today