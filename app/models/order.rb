class Order < ApplicationRecord
  validates :estimated_delivery_date, :supplier, :warehouse, presence: true
  validates :code, presence: true, uniqueness: true
  validates :estimated_delivery_date, comparison: { greater_than: Date.today, message: 'deve ser no futuro' }, on: :create
  
  has_many :order_items
  has_many :product_models, through: :order_items
  
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  enum status: { pending: 0, delivered: 5, canceled: 10 } 

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
