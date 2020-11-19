class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true, uniqueness: true
  has_one_attached :image
end
