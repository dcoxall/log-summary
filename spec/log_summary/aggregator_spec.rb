require 'spec_helper'

RSpec.describe LogSummary::Aggregator do
  let(:parser)     { instance_double(LogSummary::LineParser) }
  let(:aggregator) { described_class.new(parser) }
  let(:io)         { StringIO.new }
  subject(:result) { aggregator.consume(io) }

  let(:lines) do
    [
      LogSummary::LogLine.new('/about/2', '444.701.448.104'),
      LogSummary::LogLine.new('/contact', '543.910.244.929'),
      LogSummary::LogLine.new('/about/2', '126.318.035.038')
    ]
  end

  before do
    lines.each { |line| io.puts line.to_s }
    io.rewind
    allow(parser).to receive(:parse).and_return(*lines)
  end

  describe 'uses the parser to build the results' do
    it 'calls the parse method for each line' do
      expect(parser).to receive(:parse).exactly(3).times
      subject
    end
  end

  describe '#consume' do
    let(:lines) do
      [
        LogSummary::LogLine.new('/about', '444.701.448.104'),
        LogSummary::LogLine.new('/contact', '444.701.448.104'),
        LogSummary::LogLine.new('/contact', '444.701.448.104')
      ]
    end

    it 'returns a list of unique views' do
      expect(result.unique_views).to match [
        a_hash_including(path: '/about', count: 1),
        a_hash_including(path: '/contact', count: 1)
      ]
    end

    it 'returns a list of page views' do
      expect(result.page_views).to match [
        a_hash_including(path: '/contact', count: 2),
        a_hash_including(path: '/about', count: 1)
      ]
    end

    it 'returns the longest path size' do
      expect(result.longest_path_size).to eq(8)
    end
  end
end
