require_relative 'task'
require_relative 'view'
require_relative 'service/option_parser'
require_relative 'service/messages'

class Controller
  def initialize
    Task.create_db
    @view = View.new
  end

  def today
    @view.view_today(Task.today)
  end

  def week
    @view.view_week(Task.week)
  end

  def longterm
    @view.view_longterm(Task.longterm)
  end

  def view_done
    list = Task.done_list
    list.each do |task|
      puts "#{task.id} - #{task.title} (due #{task.due}), takes #{task.takes} days"
    end
    unless list == []
      if @view.revive?
        revive
      end
    else
      puts "no done tasks"
    end
  end

  def all
    @view.view_today(Task.today)
    @view.view_week(Task.week)
    @view.view_longterm(Task.longterm)
  end

  def add
    infos = OptionParser.new.parse_add
    if infos.nil?
      puts add_error
      puts add_help
      return
    else
      Task.new(infos).add
    end
  end

  def edit
    task = Task.find(@view.edit_selection)
    repeat = 'y'
    until repeat != 'y'
      option = @view.edit_option(task)
      case option
      when 1 then task.edit_title(@view.new_info('title'))
      when 2 then task.edit_due(@view.new_info('due'))
      when 3 then task.edit_takes(@view.new_info('takes'))
      when 4 then task.edit_top_priority
      when 5 then task.edit_repeat(@view.new_info('repeat'))
      when 6 then break
      end
      puts "Keep editing? [y/n]"
      repeat = STDIN.gets.chomp
    end
  end

  def done(id)
    case id
    when nil
      all
      @view.get_done_id
    else
      task = Task.find(id.to_i)
      puts "Marked #{task.id} - #{task.title} [done]"
      Task.done(task)
    end
  end

  def delete
    del_id = ARGV[1]
    if del_id
      task = Task.find(del_id)
      task_id = task.id
      task_title = task.title
      puts "Delete task: #{task_id} - #{task_title}? [y/n]"
      if STDIN.gets.chomp == 'y'
        task.destroy
        puts "#{task_id} - #{task_title} deleted"
      else
        puts delete_cancle
      end
    else
      @view.get_delete_id
    end
  end

  private

  def revive
    id = @view.revive_selection
    Task.revive(id)
  end
end