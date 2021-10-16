# frozen_string_literal: true

# BabyParam model
class BabyParam < ActiveRecord::Base
  belongs_to :baby

  validates :weight, :height, :date_of_measurement, presence: true

  def photo(size: :big)
    photo_path = if size == :big
                   "/uploads/#{id}_baby_param_photo_#{ImageUploader::IMAGE_SIZES[:big]}.jpg"
                 else
                   "/uploads/#{id}_baby_param_photo_#{ImageUploader::IMAGE_SIZES[:small]}.jpg"
                 end

    return photo_path if File.file?("public#{photo_path}")
  end
end
