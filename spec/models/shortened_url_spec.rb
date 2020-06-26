require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  context 'Migrations' do
    it { is_expected.to have_db_column(:url).of_type(:string).with_options(null: false) }
    it do
      is_expected.to have_db_column(:destination_url).of_type(:string).with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:access_count).of_type(:integer).
        with_options(null: false, default: 0)
    end
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context 'Validations' do
    it { is_expected.to validate_url_of(:destination_url) }
  end

  context 'Instance methods' do
    describe '#create' do
      let(:attributes)      { attributes_for(:shortened_url) }
      let(:destination_url) { attributes[:destination_url] }
      let(:url)             { Faker::Internet.url }

      before { allow(UrlShortener).to receive(:run).with(destination_url) { url } }

      it 'creates with the correct url' do
        shortened_url = described_class.create(attributes)

        expect(shortened_url.url).to eq url
      end
    end
  end
end
