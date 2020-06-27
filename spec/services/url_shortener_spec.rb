require 'rails_helper'

RSpec.describe UrlShortener do
  subject { described_class }

  describe '.base62_encode' do
    it { expect(subject.base62_encode(1)).to eq '1' }
    it { expect(subject.base62_encode(200)).to eq '3e' }
    it { expect(subject.base62_encode(12345)).to eq '3d7' }
  end
end