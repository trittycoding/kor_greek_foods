class Order < ApplicationRecord
  belongs_to :user
  validates :total, presence: true, numericality: { only_decimal: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :stripe_identifier, presence: true
  validates :paid, presence: true
end
