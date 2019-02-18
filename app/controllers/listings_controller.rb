# frozen_string_literal: true

class ListingsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :set_listing, only: %i[show update destroy]

  # GET /listings
  def index
    @listings = Listing.includes(:category, :user)
    @listings = @listings.where(user_id: @current_user.id) if @current_user&.admin?
    render_json(@listings.map(&:as_object))
  end

  # GET /listings/1

  def show
    render json: @listing
  end

  # POST /listings
  def create
    @listing = Listing.new(listing_params.merge(user_id: @current_user.id))

    if @listing.save
      render_json(@listing, true, :created)
    else
      render_json(@listing.errors, false, :unprocessable_entity)
    end
  end

  # PATCH/PUT /listings/1
  def update
    if @listing.update(listing_params)
      render json: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /listings/1
  def destroy
    @listing.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def listing_params
    params.permit(:views, :description, :category_id, :disabled, :price_per_hour, :offer_description, :offer_price)
  end
end
