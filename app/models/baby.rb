# frozen_string_literal: true

# Baby model
class Baby < ActiveRecord::Base
  belongs_to :user
  has_many :baby_params
  has_many :sleeps
  has_many :feedings

  enum gender: { girl: 'G', boy: 'B' }

  def photo(size: :big)
    photo_path = if size == :big
                   "/uploads/#{id}_#{name}_250x250.jpg"
                 else
                   "/uploads/#{id}_#{name}_50x50.jpg"
                 end

    return photo_path if File.file?("public#{photo_path}")
  end
end
