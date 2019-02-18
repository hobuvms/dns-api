# frozen_string_literal: true

class ImagesController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_image, only: %i[show update destroy]

  # POST /images
  def create
    @image = Image.upload_image(params[:image], validate_object(params))

    if @image.image_url
      render_json({ url: @image.image_url, id: @image.id }, true, :created)
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  private

  def validate_object(params)
    return nil unless params['id'].present? && params['object'].present?
    if Image.find_imageable(params['id'], params['object']).present?
      raise ActiveRecord::RecordNotFound, 'Object Already Mapped'
    end

    params['object'].titleize.constantize.find(params['id'])
  end
end
