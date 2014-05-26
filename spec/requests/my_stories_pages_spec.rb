require 'spec_helper'

describe 'My stories' do
  subject { page }

  it 'should require authentication' do
    # Can be better tested on controller level
    visit my_stories_path
    current_path.should == new_user_session_path
  end

  context 'user logged in' do
    let(:user) { FactoryGirl.create :user_with_stories }
    let(:other_user) { FactoryGirl.create :user }

    it 'should see his own stories' do
      login user
      visit my_stories_path
      user.stories.each { |story|
        expect(page).to have_text story.translation.title
      }
    end

    it 'should not see other\'s stories' do
      login other_user
      visit my_stories_path
      user.stories.each { |story|
        expect(page).to_not have_text story.translation.title
      }
    end
  end
end
