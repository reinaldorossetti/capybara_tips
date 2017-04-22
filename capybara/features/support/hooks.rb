
Before do |feature|

  ## configure the chosen browser
  Capybara.configure do |config|
    config.default_driver = :selenium
  end

  ## set default max wait and maximize browser
  Capybara.default_max_wait_time = 60
  # configurar o browser maximizado.
  Capybara.page.driver.browser.manage.window.maximize

end
