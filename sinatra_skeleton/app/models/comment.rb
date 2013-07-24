class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validate :content, presence: true
end
