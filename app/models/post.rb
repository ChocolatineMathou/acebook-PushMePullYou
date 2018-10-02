class Post < ApplicationRecord
  belongs_to :customer
  has_many :likes
end
