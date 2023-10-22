class Order < ApplicationRecord
  validates :estimated_delivery_date, :supplier, :warehouse, presence: true
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
end
