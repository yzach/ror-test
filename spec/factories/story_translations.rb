
FactoryGirl.define do
  factory :story_translation do
    auto_translated false

    factory :story_translation_en do
      association :language, factory: :english
      title "Story title english"
      text "Story text english"
    end

    factory :story_translation_ru do
      association :language, factory: :russian
      title "Story title russian"
      text "Story text russian"
    end

    factory :story_translation_he do
      association :language, factory: :hebrew
      title "Story title hebrew"
      text "Story text hebrew"
    end
  end
end
