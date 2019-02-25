class Order < ApplicationRecord
  belongs_to :vendor, class_name: 'User'
  belongs_to :user_lead

  validates_presence_of :user_lead_id, :vendor_id, :product_id
  has_paper_trail

  before_save :touch_user_lead

  def as_object
    as_json(only: %i[id product_id account_number taxed status working_order company_name price installation expiry_date details
					 created_at])
  end

  def touch_user_lead
    user_lead.touch
  end

end
