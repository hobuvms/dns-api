# frozen_string_literal: true

class AreaOfService < ApplicationRecord
  extend RedisHelper
  has_and_belongs_to_many :users
  def self.list
    hash_data = get_cache_for_string 'AreaOfServiceHash'
    if hash_data.blank?
      hash_data = AreaOfService.all.to_json
      set_cache_for_string('AreaOfServiceHash', hash_data, expiry_time: 15.days.to_i)
    end
    JSON.parse hash_data
  end
end
