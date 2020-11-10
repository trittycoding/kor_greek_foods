class Product < ApplicationRecord
  belongs_to :category
  validates :name, :description, presence: true
  validates :price, presence: true, numericality: { only_decimal: true }
end
