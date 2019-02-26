# User Model
class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password_digest, :role
  validates_uniqueness_of :email
  enum role: { user: 100, vendor: 200, admin: 500 }
  enum media: { referral: 100, internet: 200, social: 300, direct: 400 }
  after_create :generate_referral_code

  has_many :orders, foreign_key: :vendor_id
  has_many :user_leads, foreign_key: :vendor_id

  has_one :user_address

  accepts_nested_attributes_for :user_address

  def as_object
    as_json(only: %i[id name email role phone referral_code company_name notes], include: :user_address)
  end

  def generate_referral_code
    return if referral_code.present?

    code = email.split(/\W+/).first
    code = email.split(/\W+/).join[0...5] if code.blank? || code.to_s.length < 5
    update_attributes(referral_code: code+id.to_s)
  end

  def self.to_csv
    attributes = ["id", "name", "company_name", "medium", "price", "first_contact_date", "last_updated", "customer_name", "status", "formatted_address", "unit", "city", "postal_code", "phone_number", "tv", "internet", "hp", "shm", "account_number", "working_order", "installation", "installation_date", "installation_time", "activated", "details", "expiry_date"]

    head_attributes = ["Service Company", "Medium", "Company", "Price", "First Contact Date (system)", "Latest Date Updated (system)", "Customer Name", "PROGRESS STATUS", "Street Address", "Unit", "City", "Postal Code", "Contact Phone", "TV Sale", "Int Sale", "HP Sale", "SHM", "Rep Name", "Account #", "Work Order #", "Install Date", "Install Time", "Activated", "Rep Paid", "Comments DETAILS", "EXPIRY"]

    CSV.generate(headers: true) do |csv|
      csv << head_attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
