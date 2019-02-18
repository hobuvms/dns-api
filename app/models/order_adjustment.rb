# frozen_string_literal: true

class OrderAdjustment < ApplicationRecord
  belongs_to :order, foreign_key: :order_uuid, primary_key: :uuid
end
