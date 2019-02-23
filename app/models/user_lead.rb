# User Leads

class UserLead < ApplicationRecord
  belongs_to :user
  belongs_to :vendor, class_name: 'User'
  has_many :orders
	
	def as_object
	  	as_json(only: %i[id medium phone created_at updated_at],
                include: {user: {only: %i[id]}})
	end  
end
