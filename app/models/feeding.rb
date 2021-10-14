# frozen_string_literal: true

# Feeding model
class Feeding < ActiveRecord::Base
  belongs_to :baby

  enum status: {
    running: 0,
    finished: 1
  }

  enum breast: {
    left: 'L',
    right: 'R'
  }
end
