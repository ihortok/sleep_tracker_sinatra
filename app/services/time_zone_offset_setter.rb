# frozen_string_literal: true

# TimeZoneOffsetSetter service
class TimeZoneOffsetSetter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    time_zone_offset_in_min = TZInfo::Timezone.get(user.time_zone).utc_offset

    hour, min = time_zone_offset_in_min.divmod(3600)

    time_zone_offset = "#{time_zone_offset_in_min.positive? ? '+' : '-'}%02d:%02d" % [hour, min]

    if user.persisted?
      user.update(time_zone_offset: time_zone_offset)
    else
      user.time_zone_offset = time_zone_offset
    end
  end
end
