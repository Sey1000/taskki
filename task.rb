require 'sqlite3'
require 'faker'
require_relative 'service/priority_algorithm'

class Task
  attr_reader :title, :takes, :top_priority, :reoccur, :interval, :done
  attr_accessor :id, :due, :score, :numbering
  DB = SQLite3::Database.new('/Users/sey/Desktop/Work/Github_Projects/task_manager/db/tasks.db')
  def initialize(infos = {})
    @id = infos['id']
    @title = infos['title']
    @due = infos['due']
    # if no due date, it's automatic priority
    @takes = infos['takes'] || 0
    # if no due, but only takes, due will be set automatically (today + takes)
    @top_priority = (infos['top_priority'] == 1 ? true : false) || false
    @reoccur = (infos['reoccur'] || 7
    # @interval = infos['interval']
    @done = (infos['done'] == 1 ? true : false) || false
  end

  def self.today
    return Task.all.today
  end

  def self.week
    return Task.all.week
  end

  def self.longterm
    return Task.all.longterm
  end

  def self.all
    DB.results_as_hash = true
    result = DB.execute("SELECT * FROM tasks")
    instance_arr = []
    result.each do |infos|
      instance_arr << Task.new(infos)
    end
    algo = PriorityAlgorithm.new(instance_arr)
    return algo
  end

  def add

  end

  def save
    @id ? update : insert
  end

  def insert
    pr = @top_priority ? 1 : 0
    ro = @reoccur ? 1 : 0
    dn = @done ? 1 : 0
    st = "
    INSERT INTO tasks (title, due, takes, top_priority, reoccur, interval, done)
    VALUES (?, ?, ?, ?, ?, ?, ?) 
    "
    DB.execute(st, self.title, self.due, self.takes, pr, ro, self.interval, dn)
    self.id = DB.last_insert_row_id
  end

  def update
    puts "gonna update"
  end

  private

  def self.create_db
    st = "
    CREATE TABLE IF NOT EXISTS`tasks` (
      `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
      `title` TEXT,
      `due` TEXT,
      `takes`  INTEGER,
      `top_priority` BOOLEAN,
      `reoccur` BOOLEAN,
      `interval` INTEGER,
      `done` BOOLEAN
    );"
    DB.execute(st)
  end

  def self.seed
    puts 'Creating 30 fake tasks...'
    30.times do
      task = Task.new(
      title: Faker::Lorem.sentence,
      due: Faker::Date.forward(100).to_s,
      takes: (0..5).to_a.sample,
      top_priority: [true, false].sample,
      reoccur: [true, false].sample
      )
      task.save
    end
    puts 'Finished!'
  end
end