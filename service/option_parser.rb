def parse_add
  infos = {}
  all_input = ARGV[1..-1].join(" ").split(" -")
  return if all_input.length > 4
  infos['title'] = all_input[0]
  all_input[1..-1].each do |str|
    arr = parse_add_options(str)
    return if arr.nil?
    infos[arr[0]] = arr[1]
  end
  return infos
end

def parse_add_options(string)
  splitted = string.split
  case splitted[0]
  when 'd', '-due'
    date = splitted[1..-1].join(" ")
    return if date == ""
    return ['due', date]
  when 't', '-takes'
    return ['takes', splitted[1].to_i]
  when 'p', '-priority'
    return ['top_priority', true]
  else
    return
  end
  # ['due', rest of string]
  # ['takes', integer]
  # ['top_priority', true]
end