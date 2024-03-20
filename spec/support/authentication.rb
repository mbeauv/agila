
# This module is used to login as a user in the tests
module Authentication
    def login_as(user, options = {})
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log In'
    end
end