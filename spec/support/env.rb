Capybara.register_driver :selenium do |app|
  require 'selenium/webdriver'
  Selenium::WebDriver::Firefox::Binary.path = "/opt/firefox17/firefox"
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end
