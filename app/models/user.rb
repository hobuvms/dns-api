class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password_digest, :role
  validates_uniqueness_of :email
  enum role: { user: 100, vendor: 200, admin: 500 }
  after_create :generate_referral_code

  def as_object
    as_json(only: %i[id name email role phone])
  end

  def generate_referral_code
    code = email.split(/\W+/).first
    code = email.split(/\W+/).join[0...5] if code.blank? || code.to_s.length < 5
    update_attributes(referral_code: code)
  end
end
