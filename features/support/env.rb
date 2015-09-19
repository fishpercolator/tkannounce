require 'cucumber/rspec/doubles'
require 'factory_girl'
require 'tkannounce'
require_relative '../../spec/factories' # Why do I need this?

World(FactoryGirl::Syntax::Methods)
