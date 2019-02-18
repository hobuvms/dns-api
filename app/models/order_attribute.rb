class OrderAttribute < ApplicationRecord
  belongs_to :order
  belongs_to :listing_attribute

  # before_create do
  	
  # end

  delegate :attribute_name, to: :listing_attribute, prefix: true
  delegate :listing_description, to: :listing_attribute

  def listing_name
  	
  end
end
