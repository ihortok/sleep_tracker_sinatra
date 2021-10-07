# frozen_string_literal: true

# Sleeps query
class SleepsQuery
  attr_reader :baby, :sleeps

  def initialize(baby)
    @baby = baby
    @sleeps = Sleep.where(baby: baby)
  end

  def all_during_week_before(datetime)
    sleeps_hash = {}
    feedings_hash = {}

    7.times do |i|
      day = datetime - i.days
      sleeps_hash[(day).strftime('%Y-%m-%d')] = all_during(day, baby.sleeps)
      feedings_hash[(day).strftime('%Y-%m-%d')] = all_during(day, baby.feedings)
    end

    {
      sleeps: sleeps_hash,
      feedings: feedings_hash
    }
  end

  private

  def all_during(day, activities)
    activities.where(timestamps_query(day)).order(:started_at)
  end

  def timestamps_query(day)
    date_start = day.change({ hour: baby.night_sleep_finish }).utc
    date_end = date_start + 1.day

    %(
      started_at >= '#{date_start}'
      AND started_at <= '#{date_end}'
      OR finished_at >= '#{date_start}'
      AND finished_at <= '#{date_end}'
    )
  end
end
