require 'spec_helper'

RSpec.describe LogSummary::CLI do
  let(:out)    { StringIO.new }
  let(:client) { described_class.new(out) }

  describe '#execute' do
    let(:file) { 'spec/fixtures/requests.log' }

    subject do
      out.rewind
      out.read
    end

    before { client.execute(file) }

    it 'outputs the visits summary' do
      expect(subject).to include(<<OUTPUT)
VIEWS
  /home    5 views
  /contact 3 views
  /about   1 views
OUTPUT
    end

    it 'outputs the unique visits summary' do
      expect(subject).to include(<<OUTPUT)
UNIQUE VIEWS
  /home    3 unique views
  /contact 2 unique views
  /about   1 unique views
OUTPUT
    end
  end
end
