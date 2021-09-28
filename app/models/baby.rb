# frozen_string_literal: true

# Baby model
class Baby < ActiveRecord::Base
  belongs_to :user
  has_many :baby_params
  has_many :sleeps
  has_many :feedings
end
