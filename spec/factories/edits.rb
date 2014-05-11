# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :edit do
    translation_id 1
    user_id 1
    status "new"
    original_text "MyText"
    suggested_text "MyText"
  end
end
