# -*- encoding: utf-8 -*-

require 'spec_helper'

describe '#set_locale_from_url' do
  subject { page }

  before do
    visit root_path
  end

  it 'should set locale' do
    I18n.locale = :en
    expect { click_link 'ру' }.to change(I18n, :locale).to(:ru)
  end
end


describe '#auto_translation' do
  subject { page }

  context 'when viewing story' do
    let(:story) { @user.stories.first }

    before do
      @user = FactoryGirl.create :user_with_stories
      visit story_path(story, locale: 'ru')
    end

    it 'should be translated to current locale' do
      expect(page).to have_content('Story text russian')
    end
  end

  context 'when viewing story' do
    let(:story) { @user.stories.first }

    before do
      @user = FactoryGirl.create :user_with_stories
      visit story_path(story, locale: 'en')
    end

    it 'should be translated to current locale' do
      expect(page).to have_content('Story text russian:en')
    end
  end
end
