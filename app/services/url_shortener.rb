class UrlShortener
  BASE_URL = Rails.application.credentials[:base_url]

  def self.run(url)
    "#{BASE_URL}/123456"
  end
end