module SpecHelpers
  def login user
    user = FactoryGirl.create(:user) unless user

    visit new_user_session_path

    within '#new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    user
  end
end