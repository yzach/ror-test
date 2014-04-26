require 'spec_helper'

describe 'unauthenticated user buttons' do
  subject { page }

  before do
    FactoryGirl.create :user_with_stories
    visit story_path(Story.first)
  end

  it { should_not have_button('Delete') }
  it { should_not have_button('Edit') }
end

describe 'authenticated user buttons' do
  subject { page }

  before do
    @user = FactoryGirl.create :user_with_stories
  end

  context 'when viewing others posts' do
    before do
      @user = FactoryGirl.create :user
      login @user
      visit story_path(Story.first)
    end

    it { should_not have_button('Delete') }
    it { should_not have_button('Edit') }
  end

  context 'when viewing own stories' do
    before do
      login @user
      visit my_stories_path
    end

    it { should have_button('Add') }
  end

  context 'when viewing own story' do
    before do
      login_and_visit_own_story @user
    end

    it { should have_button('Delete') }
    it { should have_button('Edit') }
  end
end

describe 'CRUD' do
  subject { page }

  before do
    @user = FactoryGirl.create :user_with_stories
  end

  context 'when creating new story' do
    before do
      login @user
      visit my_stories_path
      click_button 'Add'
    end

    context 'when all fields are valid' do
      it 'story is created' do
        expect {
          create_story 'Title' => 'A new story title', 'Text' => 'A new story body'
        }.to change(Story, :count).by(1)

        expect(page).to have_selector('.alert', text: 'Story has been created')
      end
    end

    context 'when some fields are missing' do
      it 'story is not created' do
        expect {
          create_story 'Text' => 'A new story title'
        }.not_to change(Story, :count)

        expect(page).not_to have_content('Story has been created')
      end
    end

    def create_story(fields = {})
      fields.each do |field, value|
        fill_in field, with: value
      end
      click_button 'Create Story'
    end
  end

  context 'when remove story' do
    before do
      login_and_visit_own_story @user
    end

    it 'story is deleted' do
      expect {
        click_button 'Delete'
      }.to change(Story, :count).by(-1)

      expect(page).to have_selector('.alert', text: 'Story has been removed')
    end
  end

  context 'when updating story' do
    before do
      login_and_visit_own_story @user
      click_button 'Edit'
    end

    it 'should update the story' do
      title = 'A new title'

      expect {
        fill_in 'Title', with: title
        click_button 'Update Story'
      }.to change { users_story(@user).default_translation.title }.to(title)

      expect(page).to have_selector('.alert', text: 'Story has been updated')
    end
  end
end

def login_and_visit_own_story(user)
  login user
  visit story_path(users_story(user))
end

def users_story(user)
  user.stories.first
end
