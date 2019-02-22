class UserAddress < ApplicationRecord
  belongs_to :user

  validates_presence_of :formatted_address, :user_id

  before_create do
  	user_address = UserAddress.where(user_id: user_id)
  	if user_address.present?
  		user_address.delete_all
  	end
  end
end
