class Vendor < User
	default_scope { where(role: :vendor) }
	has_many :user_leads, foreign_key: :vendor_id
end
