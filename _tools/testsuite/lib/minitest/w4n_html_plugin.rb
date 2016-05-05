require 'haml'

module Minitest
  # :section: HTML Plugin

  # options parsing for the html csv generation feature
  def self.plugin_w4n_html_options(opts, options)
    default='result-'+Time.now.strftime("%Y-%m-%d-%H_%S")
    opts.on "--html [FILE]", "Report results to an html file (default: results/#{default}.html)" do |f|
      options[:html] = "results/#{f||default}.html"
    end
  end

  # adds an HTMLReporter to the reporters list
  def self.plugin_w4n_html_init(options)
    self.reporter << HTMLReporter.new(options) if options[:html]
  end

  class XXXTestResults < Array
    def details_per symbol
      self.group_by(&(symbol.to_sym)).each_pair.map do |x,y|
        nb_passed=y.count(&:passed?)
        nb_skipped=y.count(&:skipped?)
        nb_failed=y.count do |r| !r.passed? and !r.skipped? end
        nb_total=y.size
        perc=100*(nb_total-nb_failed)/nb_total
        [x,nb_passed,nb_skipped,nb_failed,nb_total,perc]
      end
    end
  end

  # * puts the results of the tests in an HTML file
  class HTMLReporter < StatisticsReporter
    attr_accessor :passed
    def initialize options
      @file=options[:html]
      super options
    end
    def record result # :nodoc:
      self.count += 1
      self.assertions += result.assertions
      results << result
    end
    def report
      super
      self.passed=count-errors-failures-skips
      File.open(@file,'w') do |f|
        f.print Haml::Helpers.render_file :results,self#results
      end
      puts "HTML file created in #{@file}"
    end
  end
end

module Haml::Helpers
  def render_file(filename,context=nil,*args)
    contents = File.read "templates/#{filename.to_s}.haml"
    Haml::Engine.new(contents).render(context,*args)
  end
  def render_head title=nil
    render_file(:head,title||"W4N RSC test suite")
  end
end
