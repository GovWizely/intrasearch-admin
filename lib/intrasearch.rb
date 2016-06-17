module Intrasearch
  class Configuration
    attr_accessor :api_key, :host_url
  end

  @configuration = Configuration.new

  class << self
    attr_reader :configuration
  end

  def self.configure
    yield @configuration
  end
end
