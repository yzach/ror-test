FactoryGirl.define do
  factory :story do
    user

    after(:create) do |story, evaluator|
      [:en, :he, :ru].each do |lang_trait|
        FactoryGirl.create :"story_translation_#{lang_trait}", story: story
      end
    end
  end
end