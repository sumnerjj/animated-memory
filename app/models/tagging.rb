class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :article
  belongs_to :post
end
