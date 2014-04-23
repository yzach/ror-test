require 'spec_helper'

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
