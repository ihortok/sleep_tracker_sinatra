# frozen_string_literal: true

# Baby model
class Baby < ActiveRecord::Base
  enum gender: { girl: 'G', boy: 'B' }

  belongs_to :user
  has_many :baby_params
  has_many :sleeps
  has_many :feedings

  validates :name, :gender, :date_of_birth,
            :falling_asleep_hour, :wakening_hour,
            presence: true

  def photo(size: :big)
    photo_path = if size == :big
                   "/uploads/#{id}_baby_photo_#{ImageUploader::IMAGE_SIZES[:big]}.jpg"
                 else
                   "/uploads/#{id}_baby_photo_#{ImageUploader::IMAGE_SIZES[:small]}.jpg"
                 end

    return photo_path if File.file?("public#{photo_path}")
  end
end
