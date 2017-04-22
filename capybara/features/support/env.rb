require 'capybara'
require 'capybara/cucumber'
require 'cucumber'
require 'selenium-webdriver'
require 'rspec'
require 'rspec/retry'

# Browser usado
BROWSER = "chrome"

Capybara.register_driver :selenium do |app|

	profile = Selenium::WebDriver::Chrome::Profile.new
	profile['autologin.enabled'] = false
	profile['extensions.password_manager_enabled'] = false
	profile['download.prompt_for_download'] = false

	Capybara::Selenium::Driver.new(app, :browser => :chrome, profile: profile)

  Capybara.default_max_wait_time = 60
  if BROWSER.eql?('chrome')
    Capybara::Selenium::Driver.new(app,
                                   :browser => :chrome,
																	 # precisa mudar o path ou adicionar o path no sistema.
                                   :driver_path => "/home/reiload/drivers/chromedriver32",
																	 # nao dar problema rodando como root (--no-sandbox).
																	 :switches=>["--no-sandbox"],
                                   :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.chrome(
                                       'chromeOptions' => {
                                           'args' => [ "start-maximized" ],
                                       }
                                   )

    )
  elsif BROWSER.eql?('firefox')
    Capybara::Selenium::Driver.new(app, :browser => :firefox,
                                     :marionette => true,
																		 # precisa mudar o path ou adicionar o path no sistema.
                                     :driver_path => "/home/reiload/drivers/geckodriver")
  elsif BROWSER.eql?('internet_explorer')
    Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
  elsif BROWSER.eql?('safari')
    Capybara::Selenium::Driver.new(app, :browser => :safari)
  end
end


RSpec.configure do |config|
  # show retry status in spec process
  config.verbose_retry = true
  # Try twice (retry once)
  config.default_retry_count = 2
  # Only retry when Selenium raises Net::ReadTimeout
  config.exceptions_to_retry = [Net::ReadTimeout]
  Capybara.javascript_driver = :webkit
end
