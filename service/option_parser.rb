def parse_add
  infos = {}
  all_input = ARGV[1..-1].join(" ").split(" -")
  return if all_input.length > 5
  infos['title'] = all_input[0]
  p all_input

  all_input[1..-1].each do |str|
    arr = parse_add_options(str)
    infos[arr[0]] = arr[1]
  end
  p infos



  return infos
end

def parse_add_options(string)
  splitted = string.split
  # case string[]

  # return 
  # ['due', rest of string]
  # ['takes', integer]
  # ['reoccur', integer]
  # ['top_priority', true]
end