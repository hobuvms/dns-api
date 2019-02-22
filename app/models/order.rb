class Order < ApplicationRecord
  belongs_to :vendor, class_name: 'User'
  belongs_to :user

  validates_presence_of :user_id, :vendor_id, :product_id
	has_paper_trail
end
