class ShortenedUrl < ApplicationRecord
  validates :url, url: true
end
