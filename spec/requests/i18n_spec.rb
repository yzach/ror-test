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
