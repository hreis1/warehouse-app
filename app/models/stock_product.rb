class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model

  validate :must_have_at_least_one_item
  validates :serial_number, presence: true

  before_validation :generate_serial_number, on: :create

  private

  def must_have_at_least_one_item
    unless order.order_items.any?
      errors.add(:order, 'não pode ser entregue pois não possui itens')
    end
  end

  def generate_serial_number
    self.serial_number = SecureRandom.alphanumeric(20).upcase
  end
end
