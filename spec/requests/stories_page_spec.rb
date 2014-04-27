require 'spec_helper'

describe 'Stories page', js: true do
  subject { page }

  before do
    FactoryGirl.create :user_with_stories
    visit root_path
  end

  context 'user clicks read untranslated'do
    it 'should show untranslated story' do
      expect(page).to have_content('Story text russian')
      within '#story-1' do
        click_link 'Read untranslated'
      end
      # ensure that opened fancybox frame has a the text "Story text russian"
      # but not "Story text russian:en"
      expect(page).to have_content(/Story text russian(?!:)/)
    end
  end
end
