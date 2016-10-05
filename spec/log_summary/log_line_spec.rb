require 'spec_helper'

RSpec.describe LogSummary::LogLine do
  let(:path)       { '/about/1' }
  let(:ip_address) { '127.0.0.1' }
  subject { described_class.new(path, ip_address) }

  describe '#path' do
    it 'returns the path' do
      expect(subject.path).to eq(path)
    end
  end

  describe '#ip_address' do
    it 'returns the ip address' do
      expect(subject.ip_address).to eq(ip_address)
    end
  end
end
