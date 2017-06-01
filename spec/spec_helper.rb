# frozen_string_literal: true

require 'bundler/setup'
require 'turnip'

Dir.glob('spec/steps/**/*.rb') { |f| load f, true }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.run_all_when_everything_filtered = true
end