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
end