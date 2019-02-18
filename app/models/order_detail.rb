# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :order, foreign_key: :order_uuid, primary_key: :uuid

  # validates :duration, numericality: { greater_than_or_equal_to: 1 }, presence: true

  # before_create do
  #   self.per_hour_cost = order.listing.price_per_hour
  # end
end
