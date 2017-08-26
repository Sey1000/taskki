class ParseAddOptions
  def initialize(string)
    @splitted = string.split
  end

  def parsed_arr
    case @splitted[0]
    when 'd', '-due'
      date = @splitted[1..-1].join(" ")
      return if date == ""
      return ['due', date]
    when 't', '-takes'
      return ['takes', @splitted[1].to_i]
    when 'p', '-priority'
      return ['top_priority', 1]
    else
      return
    end
  end
end