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
        let(:complain_button) { form.find 'input[type=submit]'}

        it 'should add a complaint record to db' do
          expect { complain_button.click }.to change(Complaint, :count).by 1
        end

        it 'should not add a comment record to db' do
          expect { complain_button.click }.not_to change(Comment, :count)
        end

        it 'should contain complaint accepted notice' do
          complain_button.click
          expect(page).to have_content I18n.t('complaints.messages.accepted')
        end

        context 'when user enters a comment' do
          let(:comment) { 'complaint[comments_attributes][0][text]' }
          before { form.fill_in comment, with: 'comment' }

          it 'should add comment to db' do
            expect { complain_button.click }.to change(Comment, :count).by 1
          end
        end
      end
    end
  end
end