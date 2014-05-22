class StoryTranslation < ActiveRecord::Base
  belongs_to :story
  belongs_to :language

  has_many :complaints, foreign_key: :translation_id
  accepts_nested_attributes_for :complaints

  validates :title, length: {in: 3..120}
  validates :text, presence: true

  after_save :refresh_translations, unless: :auto_translated?

  def original
    return self unless auto_translated?
    StoryTranslation.find_by story_id: story_id, auto_translated: false
  end

  def new_complaints
    complaints.where status: 'new'
  end

  def refresh_translations
    # TODO: make it asynchronous
    return if auto_translated?  # Stops recursion

    # Find languages other than current
    Language.where.not(id: language).each do |language|
      translation = story.translations.find_or_initialize_by(language: language)

      translation.update_attributes(
          title: translate(title, language.code),
          text: translate(text, language.code),
          auto_translated: true,
      )

      translation.save
    end
  end

private
  def translate text, language
    translator.translate(text, to: language)
  end

  def translator
    Rails.configuration.translator
  end
end
