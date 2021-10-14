# frozen_string_literal: true

require 'mini_magick'

# ImageUploader service
class ImageUploader
  IMAGE_SIZES = {
    big: '320x320',
    small: '60x60'
  }.freeze

  def initialize(id:, name:, image:)
    @id = id
    @name = name
    @image = image
  end

  def call
    return unless image

    file = File.open(image[:tempfile])
    photo_big_path = "./public/uploads/#{id}_#{name}_#{IMAGE_SIZES[:big]}.jpg"
    photo_small_path = "./public/uploads/#{id}_#{name}_#{IMAGE_SIZES[:small]}.jpg"

    photo = MiniMagick::Image.open(file)

    photo.resize(IMAGE_SIZES[:big]).write(photo_big_path)
    photo.resize(IMAGE_SIZES[:small]).write(photo_small_path)

    OpenStruct.new(success?: true)
  rescue StandardError => e
    OpenStruct.new(error: e)
  end

  private

  attr_reader :id, :name, :image
end
