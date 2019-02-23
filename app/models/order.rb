class Order < ApplicationRecord
  belongs_to :vendor, class_name: 'User'
  belongs_to :user

  validates_presence_of :user_id, :vendor_id, :product_id
  has_paper_trail

  def as_object
    as_json(only: %i[id product_id account_number working_order company_name price installation expiry_date details
					 created_at], include: {user: {only: %i[id name email phone company_name notes medium]}})
  end

  def self.as_object
    as_json(only: %i[id product_id account_number working_order company_name price installation expiry_date details
					 created_at], include: {user: {only: %i[id name email phone company_name notes medium]}})
  end
end
