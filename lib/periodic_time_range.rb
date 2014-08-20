# Use `active_support` for `TimeWithZone`
# If we need `core_ext`, then require `active_support/all`
# https://github.com/rails/rails/blob/master/activesupport/lib/active_support/all.rb
require 'active_support'
require 'active_support/time'

require 'periodic_time_range/version'

module PeriodicTimeRange

  FIFTEEN_MINUTES = 15.minutes.freeze

  def self.to_range(current_time, duration_in_secs)
    candidate_ranges(current_time, duration_in_secs).find { |r|
      r.cover?(current_time - duration_in_secs)
    }
  end

  def self.last_15_minutes
    to_range(Time.current, FIFTEEN_MINUTES)
  end

  private

  def self.start_of_latest_candidate_range(current_time, duration_in_secs)
    (current_time + duration_in_secs).beginning_of_hour
  end

  def self.candidate_ranges(current_time, duration_in_secs)
    slcr = start_of_latest_candidate_range(current_time, duration_in_secs)
    -10.upto(10).map { |n| duration_in_secs * n } # -10r, -9r, .. -r, 0, r, 2r, 3r, etc.
      .map { |s| [s, s - duration_in_secs] } # [-10r, -11r], .. [0, -r], [r, 0], [2r, r], etc.
      .map { |s| (slcr - s[0].seconds ... slcr - s[1].seconds) }
  end
end
