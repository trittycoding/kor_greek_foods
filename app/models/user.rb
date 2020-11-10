class User < ApplicationRecord
  belongs_to :customer_provinces
  validates :distributor, :email, uniqueness: true, presence: true
  validates :customer_province_id, presence: true
end
