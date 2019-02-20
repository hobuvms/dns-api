class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password_digest, :role
  validates_uniqueness_of :email
  enum role: { user: 100, vendor: 200, admin: 500 }

  def as_object
    as_json(only: %i[id name email role phone])
  end
end
