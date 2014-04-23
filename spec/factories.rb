FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@massdecision.ru"}

  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'

    factory :user_with_stories do
      ignore do
        stories_count 3
      end

      after(:create) do |user, evaluator|
        create_list :story, evaluator.stories_count, user: user
      end
    end
  end

  factory :story do
    user

    sequence(:title) {|n| "Story #{n}"}
    text 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  end
end