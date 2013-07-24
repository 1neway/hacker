class Post < ActiveRecord::Base
  belongs_to :user
  has_many   :comments
  validates  :title, :presence => true
  scope :ask, -> {where(ask_post: 1)}

end
