class Complaint < ActiveRecord::Base
  STATUSES = %w[new accepted rejected]

  belongs_to :user
  belongs_to :translation, foreign_key: :translation_id, class_name: 'StoryTranslation'

  has_many :comments, as: :commentable

  accepts_nested_attributes_for :comments, reject_if: Proc.new { |comment|
    comment[:text].blank? }

  validates_inclusion_of :status, in: STATUSES

  def position
    translation.text.index(text) or translation.text.size
  end
end
