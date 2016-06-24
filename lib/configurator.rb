require 'yaml'

module Configurator
  extend self

  def configure(config, config_filename)
    yaml = YAML.load(Rails.root.join("config/#{config_filename}").read)[Rails.env]
    yaml ||= {}
    if block_given?
      yield yaml
    else
      yaml.each do |key, value|
        config.send :"#{key}=", value
      end
    end
  end
end

