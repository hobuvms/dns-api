# User Model
class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password_digest, :role
  validates_uniqueness_of :email
  enum role: { user: 100, vendor: 200, admin: 500 }
  enum media: { referral: 100, internet: 200, social: 300, direct: 400 }
  after_create :generate_referral_code

  has_many :orders, foreign_key: :vendor_id

  has_one :user_address

  accepts_nested_attributes_for :user_address

  def as_object
    as_json(only: %i[id name email role phone referral_code company_name notes])
  end

  def generate_referral_code
    return if referral_code.present?

    code = email.split(/\W+/).first
    code = email.split(/\W+/).join[0...5] if code.blank? || code.to_s.length < 5
    update_attributes(referral_code: code+id.to_s)
  end
end
