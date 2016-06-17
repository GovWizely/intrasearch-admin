require 'yaml'

module Configurator
  extend self

  def configure(config, config_filename)
    yaml = YAML.load(Rails.root.join("config/#{config_filename}").read)[Rails.env]
    yaml ||= {}
    yaml.each do |key, value|
      config.send :"#{key}=", value
    end
  end
end

