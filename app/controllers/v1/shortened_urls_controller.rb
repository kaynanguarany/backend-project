class V1::ShortenedUrlsController < ApplicationController
  def index
    shortened_urls = ShortenedUrl.most_accessed

    json_response(shortened_urls, :ok)
  end

  def show
    shortened_url = ShortenedUrl.find_by(url: url)

    return json_response({ message: 'url not found' }, :not_found) if shortened_url.blank?

    shortened_url.increment_access!
    json_response(shortened_url, :ok)
  end

  def create
    shortened_url = ShortenedUrl.new(params_shortened_url)

    return json_response(shortened_url, :created) if shortened_url.save

    json_response({ errors: shortened_url.errors.full_messages }, :unprocessable_entity)
  end

  private

  def params_shortened_url
    params.require(:shortened_url).permit(:destination_url)
  end

  def url
    "#{Rails.application.credentials[:base_url]}/#{params[:url_code]}"
  end
end
