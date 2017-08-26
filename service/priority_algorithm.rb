# service class
require 'date'
require_relative 'clear_old'
require_relative 'due_prettifier'

class PriorityAlgorithm
  attr_reader :today, :week, :longterm, :done
  def initialize(tasks_arr)
    @tasks = tasks_arr.sort_by {|ins| ins.due}
    @done =[]
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
    today_numbering
    week_numbering
    longterm_numbering
  end

  def today_numbering
    @today.each_with_index do |task, ind|
      task.numbering = ind + 1
    end
  end

  def week_numbering
    @week.each_with_index do |task, ind|
      task.numbering = ind + 1 + @today.length
    end    
  end

  def longterm_numbering
    @longterm.each_with_index do |task, ind|
      task.numbering = ind + 1 + (@today + @week).length
    end
  end

  def prettify_due
    @today = DuePrettifier.prettify_today_due(@today)
    @week = DuePrettifier.prettify_week_due(@week)
    @longterm = DuePrettifier.prettify_longterm_due(@longterm)
  end

  def order_today
    prs = @today.select { |task| task.top_priority }
    rest = @today - prs
    prs.sort_by {|task| (Date.parse(task.due) - Date.today).to_i}
    @today = prs + rest
  end

  def load_tasks
    @tasks.each do |task|
      if task.done
        @done << task
      else
        diff = (Date.parse(task.due) - Date.today).to_i
        if diff <= task.takes || diff == 0 || task.top_priority
          @today << task
        elsif diff < 7
          @week << task
        else
          @longterm << task
        end
      end
    end
    @done.each do |task|
      ClearOld.clear(task)
    end
  end
end
