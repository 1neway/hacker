class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validate :title, presence: true
  scope :ask, -> {where(ask?: 1)}

end
