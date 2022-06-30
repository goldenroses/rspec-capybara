require "capybara/dsl"

module Pages
  class LoginPage
    include Capybara::DSL

    def set_login_credentials
      find(:id, 'user-name').set("standard_user")
      find(:id, 'password').set("secret_sauce")
      sleep(2)
    end

    def sign_in_button
      find(:id, 'login-button').click
    end

    def click_logout_button
      find(:id, 'react-burger-menu-btn').click
      find(:id, 'logout_sidebar_link').click
    end
  end
end
