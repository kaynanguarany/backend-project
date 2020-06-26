class V1::ShortenedUrlsController < ApplicationController
  def create
    @shortened_url = ShortenedUrl.new(params_shortened_url)

    return json_response(@shortened_url, :created) if @shortened_url.save

    json_response({ errors: @shortened_url.errors.full_messages }, :unprocessable_entity)
  end

  private

  def params_shortened_url
    params.require(:shortened_url).permit(:destination_url)
  end
end
