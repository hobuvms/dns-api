# frozen_string_literal: true

class OrderTrackingDetail < ApplicationRecord
  belongs_to :order, foreign_key: :order_uuid, primary_key: :uuid

  validates :state, :notes, :order_uuid, presence: true
end
