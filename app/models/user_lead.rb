# User Leads

class UserLead < ApplicationRecord
  belongs_to :user
  belongs_to :vendor, class_name: 'User'
  has_many :orders
  validates_presence_of :medium
	
	def as_object
	  	as_json(only: %i[id medium phone created_at updated_at],
                include: {user: {only: %i[id] , include: {user_address: {only: [:id, :formatted_address]}}}})
	end  

	def user_address_attributes=(params)
		unless user.user_address.present?
			user.build_user_address
		end
		user.user_address.update(params)
	end
end
