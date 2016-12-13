require 'rails_helper'
def submit_new_goal(goal_title, privacy = {private: false})
    visit new_goal_url
    fill_in "Title", with: goal_title
    if privacy[:private]
      check "Private?"
    end
    click_button "New Goal"
  end

  def build_three_goals(user)
    FactoryGirl.create(:goal, title: "pickle a pepper", author: user)
    FactoryGirl.create(:goal, title: "get octocat's autograph", author: user)
    FactoryGirl.create(:goal, title: "bake a cake", author: user)
  end

  def verify_three_goals
    visit goals_url
    expect(page).to have_content "pickle a pepper"
    expect(page).to have_content "get octocat's autograph"
    expect(page).to have_content "bake a cake"
  end
  
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

feature "CRUD of goals" do
  let!(:hello_world) { FactoryGirl.create(:user_hw) }

  before(:each) do
    login_as(hello_world)
  end

  feature "creating goals" do
    it "should have a page for creating a new goal" do
      visit new_goal_url
      expect(page).to have_content "New Goal"
    end

    it "should show the new goal after creation" do
      submit_new_goal("have some toes")
      expect(page).to have_content "have some toes"
      expect(page).to have_content "Goal saved!"
    end
  end

  feature "reading goals" do
    it "should list goals" do
      build_three_goals(hello_world)
      verify_three_goals
    end
  end

  feature "updating goals" do
    let(:goal) { FactoryGirl.create(:goal, author: hello_world) }

    it "should have a page for updating an existing goal" do
      visit edit_goal_url(goal)
      expect(page).to have_content "Edit Goal"
      expect(find_field('Title').value).to eq(goal.title)
    end

    it "should show the updated goal after changes are saved" do
      visit edit_goal_url(goal)
      fill_in "Title", with: "visit the sun"
      click_button "Update Goal"
      expect(page).not_to have_content "Edit Goal"
      expect(page).to have_content "Goal updated!"
      expect(page).to have_content "visit the sun"
    end
  end

  feature "deleting goals" do
    it "should allow the deletion of a goal" do
      build_three_goals(hello_world)
      visit goals_url
      click_button "delete 'pickle a pepper' goal"
      expect(page).not_to have_content "pickle a pepper"
      expect(page).to have_content "Goal deleted!"
    end
  end
end
