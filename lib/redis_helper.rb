# frozen_string_literal: true

module RedisHelper
  def get_cache_for_string(key)
    REDIS.get(key)
  end

  def set_cache_for_string(key, data, options = {})
    REDIS.setex(key, (options[:expiry_time] || 3600), data)
  end

  def get_cache_for_hash(key)
    REDIS.hgetall(key)
  end

  def set_cache_for_hash(key, data, options = {})
    data.each do |field, value|
      REDIS.hset(key, field, value)
    end
    REDIS.expire(key, options[:expiry_time]) if options[:expiry_time].present?
  end
end
