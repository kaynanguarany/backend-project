class UrlShortener
  KEYS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  BASE = KEYS.length

  def self.run(num)
    "#{ENV.fetch('FRONT_URL')}/#{base62_encode(num)}"
  end

  def self.base62_encode(num)
    return nil if num < 0
    return '0' if num.zero?

    recursive_call(num)
  end

  def self.recursive_call(num, str = '')
    return str if num.zero?

    recursive_call(num / BASE, KEYS[num % BASE] + str)
  end
end