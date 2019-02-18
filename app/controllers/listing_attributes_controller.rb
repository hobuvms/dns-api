class ListingAttributesController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_listing_attribute, only: [:show, :update, :destroy]

  # GET /listing_attributes
  def index
    @listing_attributes = ListingAttribute.includes(:listing).as_json(methods: :listing_description)

    render json: @listing_attributes
  end

  # GET /listing_attributes/1
  def show
    render json: @listing_attribute
  end

  # POST /listing_attributes
  def create
    @listing_attribute = ListingAttribute.new(listing_attribute_params)

    if @listing_attribute.save
      render json: @listing_attribute, status: :created, location: @listing_attribute
    else
      render json: @listing_attribute.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /listing_attributes/1
  def update
    if @listing_attribute.update(listing_attribute_params)
      render json: @listing_attribute
    else
      render json: @listing_attribute.errors, status: :unprocessable_entity
    end
  end

  # DELETE /listing_attributes/1
  def destroy
    @listing_attribute.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing_attribute
      @listing_attribute = ListingAttribute.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def listing_attribute_params
      params.fetch(:listing_attribute, {})
    end
end
