class Story < ActiveRecord::Base
  belongs_to :user

  validates :title, length: {in: 3..120}
  validates :text, presence: true
  validates :user, presence: true
end
