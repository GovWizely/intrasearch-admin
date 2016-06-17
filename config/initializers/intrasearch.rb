require 'configurator'
require 'intrasearch'

Intrasearch.configure do |config|
  Configurator.configure config, 'intrasearch.yml'
end
