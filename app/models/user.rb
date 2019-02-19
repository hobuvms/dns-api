# frozen_string_literal: true

# Customer Vendor Model
class User < ApplicationRecord
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
  validates_uniqueness_of :username, allow_blank: true, allow_nil: true

  has_one :image, as: :imageable
  has_one :vendor_detail
  has_many :listings
  has_many :orders, foreign_key: :user_uuid, primary_key: :uuid

  has_and_belongs_to_many :area_of_services
  accepts_nested_attributes_for :area_of_services, reject_if: :new_record?
  accepts_nested_attributes_for :vendor_detail
  # encrypt password
  has_secure_password

  before_create do
    self.uuid = UUID.generate
    self.verification_token = generate_token
  end

  after_create do
    update_attributes(referral: generate_referral)
  end

  enum gender: %i[female male]
  enum role: { user: 100, vendor: 200, admin: 500 }


  def generate_referral
    email.split(/\W+/).first + id.to_s
  end

  def area_of_services_attributes=(area_of_services_attributes)
    area_of_services.destroy_all
    area_of_services_attributes.each do |area_of_service|
      obj = AreaOfService.find_or_create_by(name: area_of_service[:name])
      area_of_services << obj if area_of_services.exclude? obj
    end
  end

  def as_object
    as_json(only: %i[id username first_name last_name email dob gender phone first_name bio referral],
            methods: %i[completed? image_url],
            include: [:area_of_services,
                      vendor_detail: { only: %i[unit area city province postal_code pitch
                                                experience_level image1_id image2_id],
                                       methods: %i[image1 image2] }])
  end

  def name
    "#{first_name} #{last_name}"
  end

  def image_url
    # image&.image_url
  end

  def completed?
    return false if as_json(only: %i[first_name last_name email dob gender phone]).values.any?(&:blank?)

    return false if area_of_services.blank? || vendor_detail.blank? || vendor_detail.doc_exist? || listings.blank?

    true
  end

  # Custom Methods for User Models

  def update_photo(image_id)
    image_obj = Image.find(image_id)
    return nil unless image_obj.present? && image_obj.imageable_id.blank?

    Image.where(imageable_id: id, imageable_type: 'User').delete_all
    image_obj.update_attributes(imageable_id: id, imageable_type: 'User')
  end

  def reset_password
    UserMailer.new.forgot_password(id, verification_token)
  end

  def generate_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(verification_token: random_token)
    end
  end

  def token_exist?(token)
    User.where(verification_token: token).present?
  end

  def change_password(password)
    return 'password missing' if password.blank?

    return 'password changed' if update_attributes(password: password, verification_token: generate_token)
  end
end
