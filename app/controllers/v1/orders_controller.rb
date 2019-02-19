# frozen_string_literal: true

module V1
  class OrdersController < ApplicationController
    
    skip_before_action :authenticate_request

    def index
      orders = current_user.orders
                           .includes(:user, :vendor, :order_detail, listing: :category)
                           .includes(:order_attributes=>[:listing_attribute => :listing])
                           .map(&:object)

      render_json(orders)
    end

    def create
      current_user =  User.find_or_initialize_by(email: params[:email])
      if current_user.present?
        current_user.first_name = params[:first_name]
        current_user.phone = params[:phone] if params[:phone].present?
        current_user.password = rand(36**20).to_s(36)
        current_user.save
      end

      @order = Order.new(order_params.merge(user_uuid: current_user.uuid, vendor_uuid: find_vendor(params[:referral])))

      if @order.save
        render_json(@order.object)
      else
        render_json(@order.errors, false, :unprocessable_entity)
      end
    end

    def order_params
      params.permit(:listing_id, :total, :slot, :scheduled_at, :referral,
                      order_detail_attributes: %i[per_hour_cost duration],
                      customer_address_attributes: %i[latitude longitude full_address phone],
                      order_attributes_attributes: [:listing_attribute_id, :value]
                      )
    end

    def find_vendor(referral)
      user = User.find_by_referral(referral)
      return nil if referral.nil? || user.blank?
      user.referral
    end
  end
end
