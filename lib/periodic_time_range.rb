# Use `active_support` for `TimeWithZone`
# If we need `core_ext`, then require `active_support/all`
# https://github.com/rails/rails/blob/master/activesupport/lib/active_support/all.rb
require 'active_support'
require 'active_support/time'

require_relative 'periodic_time_range/version'

module PeriodicTimeRange
  FIFTEEN_MINUTES = 15.minutes.freeze

  def self.to_range(time, duration)
    time = Time.zone.at(time.to_i)
    seconds_since_period_end = (time - time.beginning_of_day) % duration.to_i
    period_end = time - seconds_since_period_end

    (period_end - duration) ... period_end
  end

  def self.last_15_minutes
    to_range(Time.current, FIFTEEN_MINUTES)
  end
end
