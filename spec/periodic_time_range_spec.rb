require 'spec_helper'

describe PeriodicTimeRange do
  it 'has a version number' do
    expect(PeriodicTimeRange::VERSION).not_to be nil
  end

  describe '#to_range' do

    def hms(h, m, s)
      Time.zone.local(2014, 7, 23, h, m, s)
    end

    context '15 minutes between recurrences' do
      it 'returns a range of Time, based on the current time' do
        r0 = (hms(11, 45, 00) ... hms(12, 00, 00))
        r1 = (hms(12, 00, 00) ... hms(12, 15, 00))
        r2 = (hms(12, 15, 00) ... hms(12, 30, 00))
        r3 = (hms(12, 30, 00) ... hms(12, 45, 00))
        r4 = (hms(12, 45, 00) ... hms(13, 00, 00))
        io = {
          hms(12, 00, 00) => r0,
          hms(12, 14, 59) => r0,
          hms(12, 15, 00) => r1,
          hms(12, 29, 59) => r1,
          hms(12, 30, 00) => r2,
          hms(12, 44, 59) => r2,
          hms(12, 45, 00) => r3,
          hms(12, 59, 59) => r3,
          hms(13, 00, 00) => r4,
          hms(13, 14, 59) => r4
        }
        io.each do |i, o|
          result = described_class.to_range(i, 15.minutes)
          expect(result).to_not be_nil

          # Interestingly, tripple-dot ranges initialized with
          # ActiveSupport::TimeWithZone instances do not support
          # `Range#max`, but they do support `#last` so a single
          # `expect`ation is possible, though awkward.
          expect([result.min, result.last]).to eq([o.min, o.last])
        end
      end
    end

    context '6 hours between recurrences' do
      it 'returns the expected range of Time' do
        current_time = Time.zone.local(2014, 7, 23, 0, 4, 59)
        result = described_class.to_range(current_time, 6.hours)
        expect(result).to_not be_nil
        expect(result.begin).to eq(Time.zone.local(2014, 7, 22, 18, 0, 0))
        expect(result.end).to eq(Time.zone.local(2014, 7, 23, 0, 0, 0))
      end
    end

    context '10 seconds between recurrences' do
      it 'returns the expected range of Time' do
        current_time = Time.zone.local(2014, 7, 23, 0, 0, 1)
        result = described_class.to_range(current_time, 10.seconds)
        expect(result).to_not be_nil
        expect(result.begin).to eq(Time.zone.local(2014, 7, 22, 23, 59, 50))
        expect(result.end).to eq(Time.zone.local(2014, 7, 23, 0, 0, 0))
      end
    end

  end
end
