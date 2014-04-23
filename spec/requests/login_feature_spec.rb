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