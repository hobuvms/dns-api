class ListingAttribute < ApplicationRecord
  belongs_to :listing

  delegate :description, to: :listing, prefix: true
end
