# -*- encoding: utf-8 -*-

FactoryGirl.define do
  factory :story_translation do
    auto_translated false

    factory :story_translation_en do
      association :language, factory: :english
      title "Story title"
      text "Story text."
    end

    factory :story_translation_ru do
      association :language, factory: :russian
      title "Заголовок"
      text "Текст новости."
    end

    factory :story_translation_he do
      association :language, factory: :hebrew
      title "כותרת"
      text "טקסט הכתבה"
    end
  end
end
