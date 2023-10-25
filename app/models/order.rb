class Order < ApplicationRecord
  validates :estimated_delivery_date, :supplier, :warehouse, presence: true
  validates :code, presence: true, uniqueness: true
  validates :estimated_delivery_date, comparison: { greater_than: Date.today, message: 'deve ser no futuro' }
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
