require 'prawn'

module Minitest
  # :section: PDF Plugin

  # options parsing for the pdf generation feature
  def self.plugin_w4n_pdf_options(opts, options)
    default='result'
    opts.on "--pdf [FILE]", "Report results to an html file (default: results/#{default}.pdf)" do |f|
      options[:pdf] = "results/#{f||default}.pdf"
    end
  end

  # adds an HTMLReporter to the reporters list
  def self.plugin_w4n_pdf_init(options)
    self.reporter << PDFReporter.new(options) if options[:pdf]
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
  class PDFReporter < StatisticsReporter
    attr_accessor :passed
    def initialize options
      @file=options[:pdf]
      super options
    end
    def record result # :nodoc:
      self.count += 1
      self.assertions += result.assertions
      results << result
    end
    def report
      super
      tdata=[]
      tcolors=[]
      res_to_col={
        passed: '76EE00',
        skipped: '66CCCC',
        error: '808080',
        failed: 'FF2400',
      }
      results.each do |x|
        tdata << [x.class,x.name,x.result,x.time].map(&:to_s)
        tcolors << res_to_col[x.result]
      end
      Prawn::Document.generate(@file) do
        text "Results"
        table tdata,row_colors: tcolors
      end
      puts "PDF file created in #{@file}"
    end
  end
end
