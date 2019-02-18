# frozen_string_literal: true

class VendorDetail < ApplicationRecord
  belongs_to :user

  def image1
    return nil if image1_id.blank?

    Image.find(image1_id)&.image_url
  end

  def image2
    return nil if image2_id.blank?

    Image.find_by_id(image2_id)&.image_url
  end

  def doc_exist?
    image1.present? || image2.present?
  end
end
