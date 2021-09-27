# frozen_string_literal: true

# ActivityCreator service
class ActivityCreator
  attr_reader :activity_class, :started_at_param, :finished_at_param,
              :other_params, :time_zone

  def initialize(activity_class, started_at_param, finished_at_param, other_params, time_zone)
    @activity_class = activity_class
    @started_at_param = started_at_param
    @finished_at_param = finished_at_param
    @other_params = other_params
    @time_zone = time_zone
    @time_zone_offset ||= TZInfo::Timezone.get(@time_zone).utc_offset
  end

  def call
    activity = activity_class.constantize.new(params)

    if activity.save
      OpenStruct.new(success?: true)
    else
      OpenStruct.new(error: activity.errors.full_messages.join('; '))
    end
  rescue StandardError => e
    OpenStruct.new(error: e)
  end

  private

  def params
    {
      started_at: started_at,
      finished_at: finished_at,
      status: status
    }.merge(other_params)
  end

  def time_current
    @time_current ||= Time.current.in_time_zone(time_zone)
  end

  def started_at
    started_at_hash = started_at_param['started_at']

    Time.new(
      started_at_hash['year'] || time_current.year,
      started_at_hash['month'] || time_current.month,
      started_at_hash['day'] || time_current.day,
      started_at_hash['hour'] || time_current.hour,
      started_at_hash['minute'] || time_current.min,
      0,
      time_zone_offset
    )
  end

  def finished_at
    finished_at_hash = finished_at_param['finished_at']

    finished_at_hour = finished_at_hash['hour']

    return unless finished_at_hour.present?

    Time.new(
      finished_at_hash['year'] || time_current.year,
      finished_at_hash['month'] || time_current.month,
      finished_at_hash['day'] || time_current.day,
      finished_at_hash['hour'] || time_current.hour,
      finished_at_hash['minute'] || time_current.min,
      0,
      time_zone_offset
    )
  end

  def status
    return :finished if finished_at_param['finished_at']['hour']

    :running
  end
end
