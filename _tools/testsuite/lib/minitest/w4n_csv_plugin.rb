module Minitest
  # :section: CSV Plugin

  # options parsing for the csv generation feature
  def self.plugin_w4n_csv_options(opts, options)
    default='result.csv'
    opts.on '-c',"--csv [FILE]", "Report results to a csv file (default: #{default})" do |f|
      options[:csv] = f || default
    end
  end

  # adds a CSVReporter to the reporters list
  def self.plugin_w4n_csv_init(options)
    self.reporter << CSVReporter.new(options) if options[:csv]
  end

  # * puts the results of the tests in a CSV file
  # * TODO need to specify the format
  class CSVReporter < AbstractReporter
    attr_accessor :results

    def initialize options
      self.results = []
      @file=options[:csv]
    end

    def record result
      self.results << result
    end

    def report
      File.open(@file, 'w') do |file|
        results.each do |r|
          file.puts [r.class,r.name,r.passed?,r.time].join ','
        end
      end
    end
  end
end
