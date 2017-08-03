require 'sqlite3'
require 'faker'
require 'date'
require_relative 'service/priority_algorithm'
require 'fileutils'

FileUtils::mkdir_p 'db'
DB = SQLite3::Database.new('db/tasks.db')

class Task
  attr_reader :title, :takes, :reoccur, :interval
  attr_accessor :id, :due, :score, :numbering, :done, :top_priority
  def initialize(infos = {})
    Task.create_db
    @id = infos['id']
    @title = infos['title']
    @due = infos['due']
    @takes = infos['takes'] || 0
    @top_priority = (infos['top_priority'] == 1 ? true : false) || false
    @reoccur = (infos['reoccur'] == 1 ? true : false) || false
    @interval = infos['interval'] || 0
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

  def self.done_list
    return Task.all.done
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
    if @due
      @due = Date.parse(@due).to_s
    else
      if @takes
        @due = (Date.today + @takes).to_s
      else
        @due = Date.today.to_s
      end
    end
    save
  end

  def self.find(id)
    DB.results_as_hash = true
    result = DB.execute("SELECT * from tasks WHERE id = ?", id).first
    return Task.new(result)
  end

  def edit_info(info, value)
    case info
    when 'title' then @title = value
    when 'due' then @due = Date.parse(value).to_s
    when 'takes' then @takes = value
    when 'top priority'
      @top_priority = !@top_priority
      puts "Top priority toggled"
      puts ""
    when 'repeat'
      @reoccur = true
      @interval = value
    end
    save
  end

  def self.done(task)
    if task.reoccur
      task.due = (Date.today + task.interval).to_s
      puts "Reoccurring task: every #{task.interval} days, NEW due: #{task.due}"
      if task.top_priority
        puts "keep top_priority? [y/n]"
        task.top_priority = STDIN.gets.chomp == 'y'
      end
    else
      task.done = true
      task.top_priority = false
    end
    task.save
  end
  
  def self.revive(id)
    task = Task.find(id)
    task.done = false
    task.save
  end

  def save
    @id ? update : insert
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id = #{@id}")
  end

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

  private

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
    pr = @top_priority ? 1 : 0
    ro = @reoccur ? 1 : 0
    dn = @done ? 1 : 0
    st = "
    UPDATE tasks
    SET title = ?, due = ?, takes = ?, top_priority = ?, reoccur =?,
    interval = ?, done = ?
    WHERE id = #{@id}
    "
    DB.execute(st, self.title, self.due, self.takes, pr, ro, self.interval, dn)
  end
  
  # def self.seed
  #   puts 'Creating 30 fake tasks...'
  #   30.times do
  #     task = Task.new(
  #     title: Faker::Lorem.sentence,
  #     due: Faker::Date.forward(100).to_s,
  #     takes: (0..5).to_a.sample,
  #     top_priority: [true, false].sample,
  #     reoccur: [true, false].sample
  #     )
  #     task.save
  #   end
  #   puts 'Finished!'
  # end
end