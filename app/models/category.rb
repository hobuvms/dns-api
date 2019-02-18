# frozen_string_literal: true

class Category < ApplicationRecord
  include RedisHelper
  scope :child_category, ->(parent_id) { where(parent_id: parent_id) }
  scope :top, -> { where(parent_id: nil) }
  before_create :set_slug

  def self.duplicate?(column, data)
    Category.where("#{column}": data).present?
  end

  def set_slug
    return url if url.present?

    slug = name.parameterize
    return self.url =  slug unless Category.duplicate?('url', slug)

    loop.with_index do |_, i|
      unless Category.duplicate?('url', "#{slug}-#{i}")
        slug = "#{slug}-#{i}"
        break
      end
    end
    self.url =  slug
    # update_attribute(:url, slug)
  end

  def self.all_data(parent_id = nil)
    categories = Category.where(parent_id: parent_id).as_json(except: %i[created_at updated_at])
    categories.each do |category|
      category[:child] = all_data(category['id'])
    end
  end

  def self.details
    data = get_cache_for_string('category_details')
    if data.blank?
      data = Category.all_data.to_json
      set_cache_for_string('category_details', data, expiry_time: 150_000_000)
    end
    JSON.parse data
  end

  def self.get_cache_for_string(key)
    begin
      data = REDIS.get(key)
    rescue Redis::CommandError => e
      raise e.message
    end
    data
  end

  def self.set_cache_for_string(key, data, options = {})
    REDIS.setex(key, (options[:expiry_time] || 3600), data)
  end
end
