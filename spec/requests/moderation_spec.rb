require 'spec_helper'

describe 'when user adds a story' do
  subject { page }
  before { FactoryGirl.create :user_with_stories }

  context 'automatic translations' do
    let(:story) { StoryTranslation.find_by(auto_translated: true).story }
    before { visit story_path(story) }

    it 'should be marked as pre-moderated' do
      within '.title' do
        expect(page).to have_content(I18n.t(:premoderated))
      end
    end
  end
end
