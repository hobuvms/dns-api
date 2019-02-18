# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  has_many :order_adjustments, foreign_key: :order_uuid, primary_key: :uuid
  has_one :order_detail, foreign_key: :order_uuid, primary_key: :uuid
  has_many :order_tracking_details, foreign_key: :order_uuid, primary_key: :uuid
  has_many :order_attributes
  has_one :customer_address

  belongs_to :listing
  belongs_to :vendor, class_name: 'User', foreign_key: :vendor_uuid, primary_key: :uuid
  belongs_to :user, class_name: 'User', foreign_key: :user_uuid, primary_key: :uuid

  validates :user_uuid, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 1 }, presence: true
  validates_presence_of :order_detail, message: 'complete order details not shared'

  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
  delegate :name, to: :vendor, prefix: true

  accepts_nested_attributes_for :order_detail, :customer_address, :order_attributes

  before_create do
    # self.vendor_uuid = listing.user_uuid
    self.uuid = UUID.generate
  end

  aasm column: 'state', no_direct_assignment: false do
    state :requested, initial: true
    state :accepted
    state :en_route
    state :in_progress
    state :completed
    state :customer_canceled
    state :vendor_canceled
    
    after_all_transitions :log_status_change

    event :customer_cancel do
      transitions from: [:requested], to: :customer_canceled
    end
    event :vendor_cancel do
      transitions from: [:requested], to: :vendor_canceled
    end

    event :accept do
      transitions from: [:requested], to: :accepted
    end

    event :en_route do
      transitions from: [:accepted], to: :en_route
    end
    event :in_progress do
      transitions from: [:en_route], to: :in_progress
    end
    event :completed do
      transitions from: [:in_progress], to: :completed
    end
  end

  def log_status_change
    message = "Order state changed from #{state_was.titleize} to #{aasm.to_state.to_s.titleize}"
    order_tracking_details << OrderTrackingDetail.new(notes: message, state: aasm.to_state)
  end

  def object
    as_json(only: %i[uuid total slot],
            methods: %i[user_name user_email],
            include: { order_detail: { only: %i[notes] },
                       customer_address: { only: %i[latitude longitude full_address phone] },
                       listing: { only: %i[price_per_hour description] },
                       order_attributes: { only: %i[value], methods: %i[listing_description listing_attribute_attribute_name] } })


  end
end
