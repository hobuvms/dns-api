# frozen_string_literal: true

class Image < ApplicationRecord
  def self.upload(image)
    Cloudinary::Uploader.upload(image,
                                use_filename: true,
                                unique_filename: true)
  end

  def self.upload_image(image, object = nil)
    image_data = upload(image)
    image = Image.new(url: image_data['public_id'], width: image_data['width'],
                      height: image_data['height'], format: image_data['format'],
                      bytes: image_data['bytes'])
    if object.present?
      image.imageable_id = object.id
      image.imageable_type = object.class.to_s
    end
    image.save
    image
  end

  def image_url
    Cloudinary::Utils.cloudinary_url "#{url}.#{format}"
  end

  def self.find_imageable(id, object)
    Image.where(imageable_id: id, imageable_type: object.titleize).first
  end
end
