class ClearOld
  def initialize(done_arr)
    @done = done_arr
  end

  def clear
    @done.each do |task|
      diff = (Date.today - Date.parse(task.due)).to_i
      if diff > 30
        task.destroy
      end
    end
  end
end