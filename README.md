# PeriodicTimeRange

Recurring, sequential ranges of time e.g. "every 15 minutes" or 
"every 6 hours".  Uses [activesupport][1].

Useful for finding the most recently elapsed range of time. For
example, if it is currently 18:17, then the most recent 15 minute 
range is 18:00 - 18:15.  Range durations in minutes should evenly
divide an hour.  Durations in hours should evenly a day.  This is
not enforced, but recommended.

# Usage

```ruby
# If you are not using rails, first load activesupport and 
# set your time zone.
require 'active_support'
require 'active_support/time'
Time.zone = 'Eastern Time (US & Canada)'

# Initialize a range with the current time ..
# (usually Time.current) 
current_time = Time.zone.local(2014, 8, 20, 18, 17, 0)

# .. and a number of seconds between recurrences.
pt_range = PeriodicTimeRange.new(current_time, 15.minutes)

# Use `#to_range` to get the most recent range.  It returns 
# a `Range` of `ActiveSupport::TimeWithZone`.
range = pt_range.to_range
range.begin # => Wed, 20 Aug 2014 18:00:00 EDT -04:00
range.end   # => Wed, 20 Aug 2014 18:15:00 EDT -04:00
```

[1]: https://github.com/rails/rails/tree/master/activesupport
