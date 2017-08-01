require_relative 'task'
require_relative 'view'

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
end