module LogSummary
  class LogLine
    attr_reader :path, :ip_address

    def initialize(path, ip_address)
      @path, @ip_address = path, ip_address
    end

    def hash
      [self.class, path, ip_address].hash
    end

    def ==(other)
      other.hash == hash
    end

    def to_s
      [path, ip_address].join(' ')
    end
  end
end
