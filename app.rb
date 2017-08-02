#!/usr/bin/env ruby

require 'date'
require_relative 'controller'
require_relative 'task'
require_relative 'service/messages'

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
    CON.add
  end
end

def delete
  case ARGV[1]
  when nil
    puts delete_example
    CON.all
    puts ""
    puts delete_example
  when "-h", "--help", "help" then puts delete_help
  else
    CON.delete    
  end
end

case ARGV[0]
when "view"
  view    
when "add"
  add
when "del", "delete"
  delete
else
  puts main_help
end
