# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates_presence_of :category_id#, :price_per_hour
  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :uuid, to: :user, prefix: true

  def as_object
    as_json(only: %i[id views description category_id disabled price_per_hour offer_description offer_price],
            methods: %i[category_name user_name])
  end
end
