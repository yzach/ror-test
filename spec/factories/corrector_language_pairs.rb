FactoryGirl.define do
  factory :corrector_language_pair do
    user

    factory :en_to_ru do
      association :from_language, factory: :english
      association :to_language, factory: :russian
    end

    factory :ru_to_en do
      from_language russian
      to_language english
    end
  end
end