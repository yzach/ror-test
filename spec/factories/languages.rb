# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :language do
    factory :english do
      code 'en'
      name 'English'
    end

    factory :russian do
      code 'ru'
      name 'Russian'
    end

    factory :hebrew do
      code 'he'
      name 'Hebrew'
    end

    initialize_with { Language.find_or_create_by(code: code)}
  end
end
