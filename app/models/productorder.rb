class Productorder < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :unitcost, presence: true, numericality: { only_decimal: true }
  validates :quantity, presence: true, numericality: { only_integer: true }
end
