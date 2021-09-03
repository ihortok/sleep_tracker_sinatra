# frozen_string_literal: true

# Baby model
class Baby < ActiveRecord::Base
  belongs_to :user
  has_many :baby_params
end
