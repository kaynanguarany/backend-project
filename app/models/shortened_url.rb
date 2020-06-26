class ShortenedUrl < ApplicationRecord
  validates :destination_url, url: true

  before_create :generate_url

  private

  def generate_url
    self.url = UrlShortener.run(destination_url)
  end
end
