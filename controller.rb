require_relative 'task'
require_relative 'view'
require_relative 'service/option_parser'
require_relative 'service/messages'

class Controller
  def initialize
    Task.create_db
    @view = View.new
  end

  def call_me
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

  def all
    @view.view_today(Task.today)
    @view.view_week(Task.week)
    @view.view_longterm(Task.longterm)
  end

  def view_done
    list = Task.done_list
    @view.view_done(list)
    unless list == []
      if @view.revive?
        revive
      end
    else
      puts "no done tasks"
    end
  end

  def done(id)
    case id
    when nil
      all
      @view.get_done_id
    else
      task = Task.find(id.to_i)
      @view.marking(task)
      Task.done(task)
    end
  end

  def revive
    id = @view.revive_selection
    Task.revive(id)
  end

  def add
    infos = parse_add
    if infos.nil?
      puts add_error
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
      when 1 then task.edit_info('title', @view.new_info('title'))
      when 2 then task.edit_info('due', @view.new_info('due'))
      when 3 then task.edit_info('takes', @view.new_info('takes'))
      when 4 then task.edit_info('top priority', nil)
      when 5 then task.edit_info('repeat', @view.new_info('repeat'))
      when 6 then break
      end
      puts "Keep editing? [y/n]"
      repeat = STDIN.gets.chomp
    end
  end

  def delete
    id = ARGV[1]
    task = Task.find(id)
    @view.show_this_task(task)
    choice = STDIN.gets.chomp
    if choice == 'y'
      task.destroy
      @view.deleted(task)
    else
      puts delete_cancle
    end

  end
end