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

def today
  CON.today
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
  when "-h", "--help", "help" then puts delete_help
  else
    CON.all
    puts ""
    CON.delete    
  end
end

def edit
  CON.all
  CON.edit
end

case ARGV[0]
when "view"
  view
when "today", "t"
  today
when "add"
  add
when "edit"
  edit
when "del", "delete"
  delete
else
  puts main_help
end
