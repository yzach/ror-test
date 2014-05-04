class User < ActiveRecord::Base
  ROLES = %w[corrector expert user]

  validates_uniqueness_of :email

  has_many :stories

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
end
