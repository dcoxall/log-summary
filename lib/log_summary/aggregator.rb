require 'set'

module LogSummary
  class Aggregator
    def initialize(parser)
      @parser = parser
    end

    def consume(io)
      io.each_with_object(AggregationResult.new) do |line, result|
        result << @parser.parse(line.chomp)
      end
    end

    # This is again an implementation detail. It handles the sorting
    # and collection of results. The aggregator itself just splits the
    # lines and pushes them into this collector
    class AggregationResult
      attr_reader :longest_path_size

      def initialize
        @unique_views      = Hash.new { |h, k| h[k] = Set.new }
        @page_views        = Hash.new { |h, k| h[k] = 0 }
        @longest_path_size = 0
      end

      def <<(result)
        return if result.nil?
        @unique_views[result.path] << result.ip_address
        @page_views[result.path] += 1
        if result.path.size > longest_path_size
          @longest_path_size = result.path.size
        end
      end

      def unique_views
        @unique_views.sort { |(_, a), (_, b)| b.size <=> a.size }
                     .map { |(path, set)| { path: path, count: set.count } }
      end

      def page_views
        @page_views.sort { |(_, a), (_, b)| b <=> a }
                   .map { |(path, count)| { path: path, count: count } }
      end
    end

    private_constant :AggregationResult
  end
end
