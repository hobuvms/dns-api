# User Leads

class UserLead < ApplicationRecord
  belongs_to :user
  belongs_to :vendor, class_name: 'User'
	
	def as_object
	  	as_json(only: %i[medium phone created_at updated_at],
                include: { user: { only: %i[id name email phone company_name notes medium] } })
	end  
end
