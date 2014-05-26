class Story < ActiveRecord::Base
  belongs_to :user
  has_many :translations, class_name: StoryTranslation
  has_many :languages, through: :translations

  accepts_nested_attributes_for :translations

  validates :user, presence: true

  def default_translation
    translations.where(auto_translated: false).first || translations.first
  end

  def translation lang=nil
    # Tries to retrieve translation for requested locale.
    # If this fails, tries to get the original.
    # As last resort gets any available translation.
    lang = lang || I18n.locale
    translations.joins(:language)
                .where(languages: {code: lang})
                .first || default_translation
  end
end
