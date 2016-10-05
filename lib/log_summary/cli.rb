module LogSummary
  class CLI
    def initialize(outs)
      @output_stream = outs
      @parser        = LineParser.new
      @aggregator    = Aggregator.new(@parser)
    end

    def execute(path)
      results = @aggregator.consume(File.open(path))
      [
        ['views', :page_views],
        ['unique views', :unique_views]
      ].each do |(name, meth)|
        puts name.upcase
        results.send(meth).each do |summary|
          opts = substitutions(summary, results.longest_path_size, name)
          puts format('  %<path>s %<count>d %<name>s', opts)
        end
      end
    end

    private

    def puts(str)
      @output_stream.puts(str)
    end

    def substitutions(summary, path_size, name)
      summary.merge(
        path: summary[:path].ljust(path_size),
        name: name
      )
    end
  end
end
