class OrderItem < ApplicationRecord
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0, message: 'deve ser maior que 0' }

  belongs_to :product_model
  belongs_to :order
end
