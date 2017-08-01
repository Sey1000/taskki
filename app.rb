#!/usr/bin/env ruby
require 'optparse'
require_relative 'controller'

options = {}
con = Controller.new

main_opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: taskki COMMAND [OPTIONS]"
  opt.separator  ""
  opt.separator  "Commands"
  opt.separator  "     view : view the tasks"
  opt.separator  "     add  : add new task"
  opt.separator  ""
  opt.separator  "Options"

  # opt.on("-n","--name NAME","tell the sherpa what to call you") do |name|
  #   options[:name] = name
  # end

  opt.on("-h","--help","help") do
    puts main_opt_parser
  end
end

view_opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: taskki view [OPTIONS]"
  opt.separator  ""
  opt.separator  "Options"

  opt.on("-t", "--today", "View today's task")
  opt.on("-w", "--week", "View next 7 day's task")
  opt.on("-l", "--long", "--longterm", "View long term tasks")
  opt.on("-h","--help","help") do
    puts view_opt_parser
  end
end

# add_opt_parser = OptionParser.new do |opt|
#   opt.banner = "Usage: taskki add [OPTIONS]"
#   opt.separator  ""
#   opt.separator  "Options"

#   opt.on("")
# end

# main_opt_parser.parse!
# name = options[:name] || 'Master'

case ARGV[0]
when "view"
  # VIEW OPTIONS
  case ARGV[1]
  when "-t", "--today"
    con.today
  when "-w", "--week"
    con.week
  when "-l", "--long", "--longterm"
    con.longterm
  else
    con.all
  end

when "add"
  puts "add!!"
else
  puts main_opt_parser
end

