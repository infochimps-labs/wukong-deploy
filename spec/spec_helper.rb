require 'rspec'
require 'wukong-deploy'
require 'wukong/spec_helpers'
require_relative './support/integration_helper'

RSpec.configure do |config|
  config.mock_with :rspec
  include Wukong::SpecHelpers
  include Wukong::Deploy::IntegrationHelper
end
