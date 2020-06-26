class ShortenedUrl < ApplicationRecord
  scope :most_accessed, -> { order(access_count: :desc).limit(100) }

  validates :destination_url, url: true

  before_create :generate_url

  def increment_access!
    increment!(:access_count)
  end

  def url_code
    url.split('/').last
  end

  private

  def generate_url
    self.url = UrlShortener.run(destination_url)
  end
end
