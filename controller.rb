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

  def add
    infos = parse_add
    if infos.nil?
      puts add_error
      return
    else
      Task.new(infos).add
    end
  end

  def delete
    task = Task.find(Task.find_by_numbering(ARGV[1]))
    p task
  end
end