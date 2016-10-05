require 'spec_helper'

RSpec.describe LogSummary::LineParser do
  shared_examples 'a log line parser' do |path, ip|
    it 'parses into a LogLine' do
      expect(subject).to eq(LogSummary::LogLine.new(path, ip))
    end
  end

  let(:parser)     { described_class.new }
  subject(:result) { parser.parse(line) }

  context 'when provided "/contact 543.910.244.929"' do
    it_behaves_like 'a log line parser', '/contact', '543.910.244.929' do
      let(:line) { '/contact 543.910.244.929' }
    end
  end

  context 'when provided "/help_page/1 929.398.951.889"' do
    it_behaves_like 'a log line parser', '/help_page/1', '929.398.951.889' do
      let(:line) { '/help_page/1 929.398.951.889' }
    end
  end

  context 'when provided an invalid line' do
    let(:line) { 'invalid log line format' }

    it 'returns nil' do
      expect(result).to be_nil
    end
  end
end
