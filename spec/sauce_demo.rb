require "spec_helper"
require 'page_object'

RSpec.describe 'Login' do
  before :each do
    visit("https://www.saucedemo.com/")
    Capybara.page.driver.browser.manage.window.maximize
  end

  context "Logging in with username and password" do
    it 'can load the login page', smoke: true do
      sleep(3)
      expect(@session.title).to be == "Swag Labs"
    end

    it 'can login to the dashboard', smoke: true do
      sleep(3)
      sign_in = Pages::LoginPage.new
      sign_in.set_login_credentials
      sign_in.sign_in_button

      sleep(2)

      sign_in.click_logout_button
      sleep(2)
    end
  end
end
