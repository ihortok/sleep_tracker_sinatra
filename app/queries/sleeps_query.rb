# frozen_string_literal: true

# Sleeps query
class SleepsQuery
  attr_reader :sleeps

  def initialize(baby)
    @sleeps = Sleep.where(baby: baby)
  end

  def all_during_week_before(date)
    sleeps_hash = {}

    7.times do |i|
      day = date - i.days
      sleeps_hash[(day).strftime('%Y-%m-%d')] = all_during(day)
    end

    sleeps_hash
  end

  private

  def all_during(date)
    date_start = date.beginning_of_day
    date_end = date.end_of_day

    sleeps.where(
      "started_at >= '#{date_start}'"\
      " AND started_at <= '#{date_end}'"\
      " OR finished_at >= '#{date_start}'"\
      " AND finished_at <= '#{date_end}'"
    )
  end
end
