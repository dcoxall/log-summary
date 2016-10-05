module LogSummary
  class LineParser
    def initialize
      @regexp = /
                  \A                          # start of line
                  (.*?)                       # any characters
                  \s+                         # 1 or more whitespace
                  ((?:\d{1,3}\.){3}(\d{1,3})) # an ip address
                  \z                          # end of string
                /x
    end

    def parse(line)
      line.match(@regexp) do |match|
        LogLine.new(match[1], match[2])
      end
    end
  end
end
