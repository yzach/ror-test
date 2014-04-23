require 'spec_helper'

describe 'Login feature' do
  subject { page }

  before {
    @user = FactoryGirl.create :user_with_stories
    visit root_path
  }

  it { should have_link 'Register' }
  it { should have_link 'Login' }
  it { should_not have_link 'Logout' }

  context 'user is logged in' do
    before do
      @user = FactoryGirl.create :user
      login @user
    end

    it { should_not have_link 'Register' }
    it { should_not have_link 'Login' }
    it { should have_link 'Logout' }
  end
end

describe 'My stories' do
  subject { page }

  it 'should require authentication' do
    # Can be better tested on controller level
    visit my_stories_path
    current_path.should == new_user_session_path
  end

  context 'user logged in' do
    before do
      @user = FactoryGirl.create :user_with_stories
    end

    it 'should see his own stories' do
      login @user
      visit my_stories_path
      @user.stories.each { |story|
        should have_text story.title
      }
    end

    it 'shoud not see other\'s stories' do
      user = FactoryGirl.create :user
      login user
      visit my_stories_path
      should_not have_text 'Story 1'
    end
  end
end
