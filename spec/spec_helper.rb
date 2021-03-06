require "selenium/webdriver"
require "capybara"
require "capybara/rspec"
require 'allure-rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.formatter = AllureRspecFormatter
end

include Capybara::DSL

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :firefox
end


Capybara.register_driver :firefox do |app|
  # Run local
  # Capybara::Selenium::Driver.new(app, :browser => :firefox)

  # Run on browser stack
  username = "#{ENV['BS_USERNAME']}"
  access_key = "#{ENV['BS_ACCESS_KEY']}"
  server="hub-cloud.browserstack.com"


  caps = Selenium::WebDriver::Remote::Capabilities.chrome({
                                                            'bstack:options' => {
                                                              "os" => "Windows",
                                                              "osVersion" => "7",
                                                              "local" => "false",
                                                              "seleniumVersion" => "3.10.0",
                                                            },
                                                            "browserName" => "Firefox",
                                                            "browserVersion" => "100.0",
                                                          })

  Capybara::Selenium::Driver.new(app,
                                 :browser => :remote,
                                 :url => "https://#{username}:#{access_key}@#{server}/wd/hub",
                                 :options => caps)

end
