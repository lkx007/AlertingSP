require 'savon'

module Minitest

  def self.plugin_w4n_soap_options(opts, options)
    options.merge!({host: 'localhost',user: 'admin', password: 'changeme', xml: false})
    opts.on '-h',"--host HOST", "Connect to HOST" do |x|
      options[:host] = x
    end
    opts.on '-u',"--user USER", "Connect as USER" do |x|
      options[:user] = x
    end
    opts.on '-p',"--password PASSWORD", "Use PASSWORD" do |x|
      options[:password] = x
    end
    opts.on '-x',"--xml", "Dump Soap Request / Response" do |x|
      options[:xml] = true
    end
  end

  def self.plugin_w4n_soap_init(options)
    Filter.client=Savon.client(log: options[:xml]) do |g|
      g.wsdl "http://#{options[:host]}:58080/APG-WS/wsapi/db?wsdl"
      g.basic_auth options[:user],options[:password]
    end
  end
end
