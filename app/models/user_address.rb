class UserAddress < ApplicationRecord
  belongs_to :user

  before_create do
  	user_address = UserAddress.where(user_id: user_id)
  	if user_address.present?
  		user_address.delete_all
  	end
  end
end
