module Minitest
  # :section: Benchmark Plugin

  def self.plugin_w4n_benchmark_options(opts, options)
    opts.on("-b","--benchmark","Enable benchmark") do
      options[:benchmark]=true
      options[:verbose]=true
    end
  end

  def self.plugin_w4n_benchmark_init(options)
    if options[:benchmark]
      #Watch4Net::TestSuite.enable_benchmark if options[:benchmark]
      self.reporter << BenchmarkReporter.new
    end
  end

  class BenchmarkReporter < AbstractReporter
    def initialize
      @count=0
    end
    def start
      @start=Time.now
    end
    def record result
      @count+=1
    end
    def report
      e=Time.now
      puts "\n#{@count} tests ran in #{e-@start}s"
    end
  end
end
