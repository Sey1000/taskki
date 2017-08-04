#!/usr/bin/env ruby

# Copyright 2017 Se Kyeong Cheon

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'date'
require_relative 'controller'
require_relative 'task'
require_relative 'service/messages'

CON = Controller.new

def router
  case ARGV[0]
  when "view"
    view
  when "today", "t"
    today
  when "add"
    add
  when "edit"
    edit
  when "done"
    done
  when "del", "delete"
    delete
  else
    puts main_help
  end
end

def view
  case ARGV[1]
  when "-t", "--today" then CON.today
  when "-w", "--week" then CON.week
  when "-l", "--long", "--longterm" then CON.longterm
  when "-d", "--done" then CON.view_done
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

def edit
  case ARGV[1]
  when "-h", "--help", "help" then puts edit_help
  else
    CON.all
    CON.edit
  end
end

def done
  CON.done(ARGV[1])
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


if ARGV[0].nil?
  puts main_help
else
  router
end
