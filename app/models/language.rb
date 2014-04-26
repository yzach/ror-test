class Language < ActiveRecord::Base
  has_many :story_translations

  validates_uniqueness_of :code
end
