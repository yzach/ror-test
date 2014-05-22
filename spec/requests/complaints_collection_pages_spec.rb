require 'spec_helper'

describe 'Complaining on translation' do
  subject { page }
  before { FactoryGirl.create :user_with_stories }
  before { visit root_path }

  context "When user isn't logged in" do
    let(:story) { Story.first }

    it 'no "Complain" button' do
      expect(page).to_not have_link(nil, href: new_story_complaints_path(story))
    end
  end

  context 'when user is logged in' do
    let(:story) { Story.first }
    let(:user) { FactoryGirl.create :user }

    before { login user }

    it '"Complain" button exists' do
      expect(page).to have_link(nil, href: new_story_complaints_path(story))
    end

    context 'when user clicks "Complain" button', js: true do
      let(:translation) { story.translation }
      let(:drop_down_menu) { find "#story-#{story.id} .btn.dropdown-toggle" }
      let(:complain_link) { find :xpath, ".//a[@href='#{new_story_complaints_path(story)}']" }

      before do
        drop_down_menu.click
        complain_link.click
      end

      it 'fancybox appears' do
        within '.fancybox-opened' do
          expect(page).to have_content(translation.text)
        end
      end

      context 'when user complains' do
        let(:form) { find 'form' }
        let(:suggest_text_field) { form.find_by_id 'edit_suggested_text' }
        let(:suggest_translation_button) { form.find 'input[type=submit]'}

        it 'should add record to db' do
          expect { suggest_translation_button.click }.to change(Complaint, :count).by 1
        end

        it 'should contain complaint accepted notice' do
          suggest_translation_button.click
          expect(page).to have_content I18n.t('complaints.messages.accepted')
        end
      end
    end
  end
end