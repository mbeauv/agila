# System tests that verify authentication scenarios with the application.

require 'rails_helper'

RSpec.describe "Authentication", type: :system do
    it "allows a user to sign up with valid information" do
        visit new_user_registration_path
        fill_in "Email", with: "testuser@gmail.com"
        fill_in "Username", with: "testuser"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
        expect(page).to have_content "Welcome! You have signed up successfully."
    end

    it "does not allow a user to sign up with invalid information" do
        visit new_user_registration_path
        fill_in "Email", with: ""
        fill_in "Username", with: ""
        fill_in "Password", with: ""
        fill_in "Password confirmation", with: ""
        click_button "Sign up"
        expect(page).to have_content "errors prohibited this user from being saved"
    end

    it "allows a user to log in with valid information" do
        user = create(:user)
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
        expect(page).to have_content "Signed in successfully."
    end

    it "does not allow a user to log in with invalid information" do
        visit new_user_session_path
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        click_button "Log in"
        expect(page).to have_content "Invalid Email or password."
    end

    it "allows a user to log out" do
        user = create(:user)
        login_as(user)
        click_link "Logout"
        expect(page).to have_content "Signed out successfully."
    end

    it "allows a user to change their username" do
        user = create(:user)
        login_as(user)
        click_link "Edit Profile"
        fill_in "Username", with: "newusername"
        fill_in "Current password", with: user.password
        click_button "Update"
        expect(page).to have_content "Your account has been updated successfully."
    end

end