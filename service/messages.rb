def main_help
"Usage: taskki COMMAND [OPTIONS]

COMMAND
      view                  view all tasks
      add                   add new task

OPTIONS
      -h, --help            help"
end

def view_help
"Usage: taskki view [OPTIONS]

OPTIONS
      -t, --today           View today's tasks
      -w, --week            View this week's tasks
      -l, --long,
      --longterm            View longterm tasks

      -h, --help, help      Show all view options"
end

def add_help
"Usage: taskki add TITLE [OPTIONS]

OPTIONS
      -d, --due DATE        Set due date to new task
      -t, --takes N         Add how many [N] days this task takes
      -r, --reoccur N       Turn on repeat for every [N] days
      -p, --priority        Make task top priority

      -h, --help, help      Show all add options

Default behaviors
      if 'due' is not added, task is due Today
      if 'takes' is set, but no 'due' is set, due is automatically Today + takes
      if 'reoccur' is on without N, N is set to 7"
end

def add_error
"ERROR: ADD only takes title, --due, --takes, --reoccur, and --top"
end