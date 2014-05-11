require 'spec_helper'

describe 'Adding new edit suggestion' do
  subject { page }
  before { FactoryGirl.create :user_with_stories }
  before { visit root_path }

  context "When user isn't logged in" do
    let(:story) { Story.first }

    it 'no "Suggest edit" button' do
      expect(page).to_not have_link(nil, href: new_story_edits_path(story))
    end
  end

  context 'when user is logged in' do
    let(:story) { Story.first }
    let(:user) { FactoryGirl.create :user}

    before { login user }

    it '"Suggest edit" button exists' do
      expect(page).to have_link(nil, href: new_story_edits_path(story))
    end

    context 'when user clicks "Suggest edit" button', js: true do
      let(:translation) { story.translation }
      let(:drop_down_menu) { find "#story-#{story.id} .btn.dropdown-toggle" }
      let(:open_edit_link) { find :xpath, ".//a[@href='#{new_story_edits_path(story)}']" }

      before do
        drop_down_menu.click
        open_edit_link.click
      end

      it 'fancybox appears' do
        within '.fancybox-opened' do
          expect(page).to have_content(translation.text)
        end
      end

      context 'when user suggests edit' do
        let(:form) { find 'form' }
        let(:suggest_text_field) { form.find_by_id 'edit_suggested_text' }
        let(:suggest_translation_button) { form.find 'input[type=submit]'}

        it 'should add record to db' do
          expect { suggest_translation_button.click }.to change(Edit, :count).by 1
        end

        it 'should contain edit_created notice' do
          suggest_translation_button.click
          expect(page).to have_content I18n.t(:edit_created)
        end
      end
    end
  end
end