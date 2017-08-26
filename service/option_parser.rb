require_relative 'parse_add_options'

class OptionParser
  def initialize
    @all_input = ARGV[1..-1].join(" ").split(" -")
    @infos = {}
  end

  def parse_add
    return if ARGV[1][0] == '-'
    return if @all_input.length > 4
    @infos['title'] = @all_input[0]
    @all_input[1..-1].each do |str|
      arr = ParseAddOptions.new(str).parsed_arr
      return if arr.nil?
      @infos[arr[0]] = arr[1]
    end
    return @infos
  end
end
