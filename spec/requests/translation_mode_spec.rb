require 'spec_helper'

describe 'Translation Mode' do
  subject { page }

  let(:user) { FactoryGirl.create :user_with_stories }
  let(:corrector) { FactoryGirl.create :corrector }
  let(:complaint) { FactoryGirl.create :complaint}
  let(:translation) { complaint.translation }

  context 'when user enters' do
    before { login user }
    before { visit translation_mode_path translation }

    it 'should redirect home' do
      expect(page.current_path).to eq(root_path)
    end

    it 'should pop a flash alert' do
      within '.alert.alert-danger' do
        expect(page).to have_content I18n.t :access_denied
      end
    end
  end

  context 'when corrector enters translation mode' do
    before { login corrector }
    before { visit translation_mode_path translation }

    it 'should have complaint' do
      within '.complaint' do
        expect(page).to have_content complaint.text
      end
    end

    context 'saves translation', js: true do  # Translation editor requires JS
      it 'should save changes' do
        message = 'Edit test message'
        #fill_in 'translation_editor', with: message
        editor = find(:css, 'div.translation_editor')
        editor.set message
        click_button 'Submit'
        expect { translation.reload }.to change(translation, :text).to message
      end
    end
  end
end