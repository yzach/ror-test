
FactoryGirl.define do
  factory :complaint do
    user

    after(:build) do |complaint, evaluator|
      story = FactoryGirl.create :story

      complaint.translation = story.translation
      complaint.text = story.translation.text.split('.').first
    end
  end
end
