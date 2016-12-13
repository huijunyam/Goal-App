require 'spec_helper'
require 'rails_helper'

def sign_up_as(username)
  visit new_user_url
  fill_in "Username", with: username
  fill_in "Password", with: "password"
  click_button "Sign Up"
end

def login_as(user)
  visit new_session_url
  fill_in "Username", with: user.username
  fill_in "Password", with: "password"
  click_button "Log In"
end

feature "the signup process" do
  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up!"
  end

  it "shows username on the homepage after signup" do
    sign_up_as('hello_world')
    expect(page).to have_content "Welcome hello_world"
  end
end

feature "logging in" do
  let!(:hello_world) { FactoryGirl.create(:user_hw) }

  it "shows username on the homepage after login" do
    login_as(hello_world)
    expect(page).to have_content "Welcome hello_world"
  end
end

feature "logging out" do
  let!(:hello_world) { FactoryGirl.create(:user_hw) }

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content "Log In"
  end

  it "doesn't show username on the homepage after logout" do
    login_as(hello_world)
    click_button "Log Out"
    expect(page).not_to have_content "hello_world"
  end
end
