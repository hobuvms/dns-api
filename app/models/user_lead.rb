# User Leads

class UserLead < ApplicationRecord
  belongs_to :user
  belongs_to :vendor, class_name: 'User'
  
end
