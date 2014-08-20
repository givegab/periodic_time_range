# Use `active_support` for `TimeWithZone`
# If we need `core_ext`, then require `active_support/all`
# https://github.com/rails/rails/blob/master/activesupport/lib/active_support/all.rb
require 'active_support'
require 'active_support/time'

require 'periodic_time_range/version'

class PeriodicTimeRange

  attr_reader :current_time, :recurrence

  def initialize(current_time, seconds_between_recurrences)
    @current_time = current_time
    @recurrence = seconds_between_recurrences
  end

  def to_range
    candidate_ranges.find { |r| r.cover?(current_time - recurrence) }
  end

  private

  def start_of_latest_candidate_range
    (current_time + recurrence).beginning_of_hour
  end

  def candidate_ranges
    slcr = start_of_latest_candidate_range
    -10.upto(10).map { |n| recurrence * n } # -10r, -9r, .. -r, 0, r, 2r, 3r, etc.
      .map { |s| [s, s - recurrence] } # [-10r, -11r], .. [0, -r], [r, 0], [2r, r], etc.
      .map { |s| (slcr - s[0].seconds ... slcr - s[1].seconds) }
  end

end
