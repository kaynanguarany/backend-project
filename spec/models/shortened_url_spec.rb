require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  context 'Migrations' do
    it { is_expected.to have_db_column(:url).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:destination_url).of_type(:string).with_options(null: false) }
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
end
