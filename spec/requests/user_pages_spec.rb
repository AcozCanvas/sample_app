require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector 'h1', text: 'Sign up' }
    it { should have_selector 'title', text: full_title('Sign up') }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector 'h1', text: user.name }
    it { should have_selector 'title', text: user.name }
  end

  describe "signup" do

    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector 'title', text: 'Sign up' }
        it { should have_selector '#error_explanation .alert-error', text: 'error' }
      end

      describe "with invalid password" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: ""
          fill_in "Confirmation", with: ""
          click_button submit
        end

        it { should have_selector '#error_explanation', text: "Password can't be blank" }
        it { should_not have_selector '#error_explanation', text: "Password digest" }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }

        it { should have_selector 'title', text: full_title("Example User") }
        it { should have_selector '.alert.alert-success', text: "Welcome to the Sample App!" }
        it { should have_link 'Sign out' }
      end
    end
  end
end
