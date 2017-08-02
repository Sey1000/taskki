#!/usr/bin/env ruby

require 'date'
require_relative 'controller'
require_relative 'task'
require_relative 'service/messages'
require_relative 'service/option_parser'

CON = Controller.new

def view
  case ARGV[1]
  when "-t", "--today" then CON.today
  when "-w", "--week" then CON.week
  when "-l", "--long", "--longterm" then CON.longterm
  when "-h", "--help", "help" then puts view_help
  else
    CON.all
  end
end

def add
  case ARGV[1]
  when "-h", "--help", "help", nil then puts add_help
  else
    infos = parse_add
    if infos.nil?
      puts add_error
      return
    else
      Task.new(infos).add
    end
  end
end

case ARGV[0]
when "view"
  view    
when "add"
  add
else
  puts main_help
end
