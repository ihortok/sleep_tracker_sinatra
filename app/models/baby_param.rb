# frozen_string_literal: true

# BabyParam model
class BabyParam < ActiveRecord::Base
  belongs_to :baby

  validates :weight, :height, :measurement_date, presence: true

  def photo(size: :big)
    photo_path = if size == :big
                   "/uploads/#{id}_baby_param_photo_250x250.jpg"
                 else
                   "/uploads/#{id}_baby_param_photo_50x50.jpg"
                 end

    return photo_path if File.file?("public#{photo_path}")
  end
end
