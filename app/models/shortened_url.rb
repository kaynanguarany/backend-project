class ShortenedUrl < ApplicationRecord
  validates :destination_url, url: true
end
