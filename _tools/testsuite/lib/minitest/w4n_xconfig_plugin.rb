module Minitest
  # :section: Configuration File Plugin

  def self.plugin_w4n_xconfig_options(opts, options)
    customopts=(YAML.load_file('./config.yml') rescue {}).sym_keys
    options.merge!(customopts)
  end
end

class Hash
  def sym_keys
    each_with_object({}) do |(k,v),o|
      o[k.to_sym]=v
    end
  end
end
