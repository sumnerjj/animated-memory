class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  default_scope { order("created_at DESC") }
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :body, presence: true, length: { minimum: 1 }

  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
