# frozen_string_literal: true

describe DaData::Request do
  subject { described_class.new(:suggest_address) }

  before { allow(subject.client).to receive(:post).and_return('{"a": 1}') }

  describe '.new' do
    it { expect(subject.content_type).to eq 'application/json' }
    it {
      expect(subject.client.default_options.headers.to_h)
        .to include('Content-Type' => 'application/json', 'Accept' => 'application/json')
    }
  end

  describe '#query' do
    it { expect(subject.query('')).to eq('a' => 1) }
  end
end
