class Vendor < User
	default_scope { where(role: :vendor) }
	has_many :user_leads
end
