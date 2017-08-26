class ClearOld
  def self.clear(task)
    diff = (Date.today - Date.parse(task.due)).to_i
    task.destroy if diff > 30
  end
end