module Minitest
  # :section: Modules Plugin

  # options parsing for the modules option
  def self.plugin_w4n_modules_options(opts, options)
    opts.on '-m',"--modules PATTERN", "Only run test in modules matching PATTERN" do |x|
      options[:modules] = Regexp.new(x,Regexp::IGNORECASE)
    end
    opts.on '-p',"--prefilter FILTER", "All queries will append FILTER to their normal filter" do |x|
      options[:prefilter] = x
    end
  end

  # removes modules not mactching the pattern
  def self.plugin_w4n_modules_init(options)
    if options[:modules]
      Runnable.runnables.reject! do |r|
        r.superclass==W4NTest and not options[:modules].match r.name
      end
    end
    if options[:prefilter]
      Filter.prefilter=options[:prefilter]
    end
  end
end
