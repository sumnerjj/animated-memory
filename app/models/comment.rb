class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :commentable, polymorphic: true
  default_scope { order("created_at DESC") }
  validates :body, presence: true, length: { minimum: 1 }
end
