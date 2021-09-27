# frozen_string_literal: true

# ActivityTerminator service
class ActivityTerminator
  attr_reader :activity, :finished_at_param, :time_zone

  def initialize(activity, finished_at_param, time_zone)
    @activity = activity
    @finished_at_param = finished_at_param
    @time_zone = time_zone
    @time_zone_offset ||= TZInfo::Timezone.get(@time_zone).utc_offset
  end

  def call
    activity.finished_at = finished_at
    activity.status = :finished

    if activity.save
      OpenStruct.new(success?: true)
    else
      OpenStruct.new(error: activity.errors.full_messages.join('; '))
    end
  rescue StandardError => e
    OpenStruct.new(error: e)
  end

  private

  def time_current
    @time_current ||= Time.current.in_time_zone(time_zone)
  end

  def finished_at
    finished_at_hash = finished_at_param['finished_at']

    finished_at_hour = finished_at_hash['hour']

    raise 'Finish time must be specified.' unless finished_at_hour.present?

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
end
