class CorrectorLanguagePair < ActiveRecord::Base
  belongs_to :user
  belongs_to :from_language, class_name: Language
  belongs_to :to_language, class_name: Language
end
