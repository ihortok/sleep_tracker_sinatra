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

    7.times do |i|
      day = datetime - i.days
      sleeps_hash[(day).strftime('%Y-%m-%d')] = all_during(day)
    end

    sleeps_hash
  end

  private

  def all_during(day)
    date_start = day.change({ hour: baby.night_sleep_finish }).utc
    date_end = date_start + 1.day

    sleeps.where(
      "started_at >= '#{date_start}'"\
      " AND started_at <= '#{date_end}'"\
      " OR finished_at >= '#{date_start}'"\
      " AND finished_at <= '#{date_end}'"
    ).order(:started_at)
  end
end
