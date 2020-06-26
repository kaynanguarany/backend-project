class ShortenedUrl < ApplicationRecord
  validates :destination_url, url: true

  before_create :generate_url

  def increment_access
    increment!(:access_count)
  end

  private

  def generate_url
    self.url = UrlShortener.run(destination_url)
  end
end
