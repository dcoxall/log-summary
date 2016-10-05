Log Summary
===========

Log Summary is a simple ruby application that can parse a basic log file format:

    /homepage 192.168.0.1
    /about/1 192.168.0.1
    /videos/cats 127.0.0.1
    /homepage 192.168.0.1

Usage
-----

It comes with a very simple CLI that can be used as follows:

    $ bin/parser.rb /path/to/log_file.log
    VIEWS
      /homepage    2 views
      /about       1 views
      /viedos/cats 1 views
    UNIQUE VIEWS
      /homepage    1 unique views
      /about       1 unique views
      /viedos/cats 1 unique views

Development
-----------

To run the test suite you can use:

    $ bin/rspec -c

Architecture
------------

- Use dependency injection to support patterns such as **strategy pattern**. This could
  then be used to parse more complex log lines without changing much code. The parser
  could even be switched out based on command line arguments.
- Avoid hashes in **favour of custom objects**. Ruby engineers have a tendency to favor hash
  driven development but it makes code inflexible IMO.
- **Keep logic outside of executables** and in classes instead. This makes even the CLI output
  testable.

Recommendations
---------------

Refactor the `Aggregator` to better support multiple aggregations. Potentially something like:

    # pseudo code
    result_builder = ResultBuilder.new
    # aggregation classes have a basic interface
    result_builder.add_aggregator(UniqueViewsAggregator.new)
    result_builder.add_aggregator(ViewCountAggregator.new)
    result_builder << LogLine.new('/path', 'ip')
    result_builder.to_s # => output results?
