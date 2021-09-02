# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  has_secure_password
end
