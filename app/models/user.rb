class User < ActiveRecord::Base
  ROLES = %w[corrector expert user]

  validates_uniqueness_of :email

  has_many :stories
  has_many :complaints
  has_many :language_pairs, class_name: CorrectorLanguagePair

  accepts_nested_attributes_for :language_pairs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def corrector?
    role == 'corrector'
  end

  def expert?
    role == 'expert'
  end

  def admin?
    is_admin
  end

  def can_translate? translation
    pairs = language_pairs.map {|p| [p.from_language_id, p.to_language_id]}
    pair = [translation.story.default_translation.language_id, translation.language_id]
    pairs.include? pair
  end
end
