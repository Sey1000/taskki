# Taskki
Commnad line task manager written in Ruby

## Installation
1. Clone or download
2. `cd taskki`
3. `gem install bundler` if you don't have bundler yet
3. `bundle install`
4. `ln -s $PWD/app.rb /usr/local/bin/taskki`

## Usage Example
To see all commands:
```
taskki
```

For example, 'add' can take TITLE, then multiple options
(After title in the beginning, options can be in any order)
`-d DATE` due date
`-t INTEGER` takes how many # days
`-p` make it top-priority
```
taskki add schedule meeting with Maria -p -d Aug 5 -t 3
```

## Contribution
This project is still pretty raw, and being updated regularly.
Any contribution is appreciated! You can:
1. Fork it!
2. Use it!
3. Try to break it and let me know of all your success stories ;)
4. Making 'Issues' up there is a recommended way to report 

## History
2017-08-03 release alpha

## License
See the LICENSE.md file for license rights and limitations (Apache 2.0).