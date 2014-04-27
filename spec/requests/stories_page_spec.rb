require 'spec_helper'

describe 'Stories page', js: true do
  subject { page }

  before do
    FactoryGirl.create :user_with_stories
    visit root_path
  end

  context 'user clicks read untranslated'do
    it 'should show untranslated story' do
      within '#story-1' do
        click_link 'Read untranslated'
      end
    end
  end
end
