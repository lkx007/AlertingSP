module Minitest
  # :section: Quiet Plugin

  # options parsing for the quiet option
  def self.plugin_w4n_quiet_options(opts, options)
    opts.on '-q',"--quiet", "Quiet mode (removes default reporters)" do
      options[:quiet] = true
    end
  end

  # removes the default reporters
  def self.plugin_w4n_quiet_init(options)
    if options[:quiet]
      # TODO also remove the output from Watch4Net::TestSuite?
      to_remove=[Minitest::ProgressReporter,Minitest::SummaryReporter]
      self.reporter.reporters.reject! do |r|
        to_remove.any? do |x| x === r end
      end
    end
  end
end
