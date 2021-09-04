# frozen_string_literal: true

# Sleep model
class Sleep < ActiveRecord::Base
  belongs_to :baby

  enum status: {
    running: 0,
    finished: 1
  }
end
