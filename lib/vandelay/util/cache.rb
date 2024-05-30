require 'redis'

module Vandelay
  module Util
    class Cache
      def initialize
        @redis = Redis.new(url: Vandelay.config.dig("persistence", "redis_url"))
      end

      def read(key)
        @redis.get key
      end

      def write(key, data, expiry = 10 * 60)
        @redis.set key, data
        @redis.expire key, expiry
      end

      def self.instance
        @cache ||= Cache.new
      end
    end
  end
end
