FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@massdecision.ru"}

  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'

    factory :corrector do
      ignore do
        no_languages false
      end

      role 'corrector'

      after(:create) do |corrector, evaluator|
        unless evaluator.no_languages
          FactoryGirl.create :en_to_ru, user: corrector
        end
      end
    end

    factory :user_with_stories do
      ignore do
        stories_count 3
      end

      after(:create) do |user, evaluator|
        create_list :story, evaluator.stories_count, user: user
      end

      factory :user_with_stories_and_complaints do

      end
    end
  end
end