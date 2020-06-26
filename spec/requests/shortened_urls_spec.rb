require 'rails_helper'

RSpec.describe 'Shortened Urls' do
  describe 'GET /v1/shortened_url/:url' do
    let(:shortened_url) { create(:shortened_url) }

    before { get v1_shortened_url_path(url_code) }

    context 'with persisted url' do
      let(:url_code) { shortened_url.url_code }

      it 'finds a shortened_url' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include(
          {
            "access_count" => shortened_url.access_count,
            "destination_url" => shortened_url.destination_url,
            "url" => shortened_url.url,
          }
        )
      end
    end

    context 'with inexistent url' do
      let(:url_code) { Faker::Alphanumeric.alphanumeric(number: 6) }

      it "can't find a shortened_url" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /v1/shortened_urls' do
    let(:url) { Faker::Internet.url }
    let(:params) do
      {
        shortened_url: { destination_url: destination_url },
      }
    end

    before do
      allow(UrlShortener).to receive(:run).with(destination_url) { url }

      post v1_shortened_urls_path, params: params
    end

    context 'with valid destination_url' do
      let(:destination_url) { Faker::Internet.url }

      it 'creates a shortened_url' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include(
          {
            "access_count" => 0,
            "destination_url" => destination_url,
            "url" => url,
          }
        )
      end
    end

    context 'with invalid destination_url' do
      let(:destination_url) { Faker::Lorem.word }

      it 'creates a shortened_url' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include(
          {
            "errors" => ["Destination url is not a valid URL"],
          }
        )
      end
    end
  end
end
