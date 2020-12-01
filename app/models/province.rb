class Province < ApplicationRecord
  has_many :users
  validates :name, :abbreviation, uniqueness: true
  validates :name, :abbreviation, :taxrate, presence: true
end
