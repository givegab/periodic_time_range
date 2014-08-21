# PeriodicTimeRange

Recurring, sequential ranges of time e.g. "every 15 minutes" or 
"every 6 hours".  Uses [activesupport][1].

Range durations in minutes are assumed to evenly divide an hour,
and durations in hours are assumed to evenly divide a day, etc.

PeriodicTimeRange is useful for finding the most recently elapsed
range of time. For example, if it is currently 18:17, then the most
recent 15 minute range is 18:00 - 18:15.

This is useful for scheduled jobs that run periodically throughout
the day.  For example, a job that runs every 15 minutes may be
interested in database records from the past 15 minutes.
Given that scheduled jobs might not run exactly at the scheduled
time, some periodic jobs are deliberately run a few minutes after
the time range ends, avoiding some boundary conditions.  For example,
a job interested in the range 18:00 - 18:15 may be deliberately run
a few minutes later, at 18:17.

# Usage

```ruby
# If you are not using rails, first load activesupport and 
# set your time zone.
require 'active_support'
require 'active_support/time'
Time.zone = 'Eastern Time (US & Canada)'

# Given the current time .. (usually Time.current)
current_time = Time.zone.local(2014, 8, 20, 18, 17, 0)

# .. and a number of seconds between recurrences,
# use `.to_range` to get the most recent range.  It returns
# a `Range` of `ActiveSupport::TimeWithZone`.
range = PeriodicTimeRange.to_range(current_time, 15.minutes)
range.begin # => Wed, 20 Aug 2014 18:00:00 EDT -04:00
range.end   # => Wed, 20 Aug 2014 18:15:00 EDT -04:00

# Because `Time.current` and `15.minutes` is the most common
# use case, there's a shortcut.
PeriodicTimeRange.last_15_minutes
```

[1]: https://github.com/rails/rails/tree/master/activesupport
