class ProductModel < ApplicationRecord
  validates :name, :sku, :weight, :height, :width, :depth, presence: true
  validates :sku, uniqueness: true
  validates :weight, :height, :width, :depth, numericality: { greater_than: 0 }
  validates :sku, length: { is: 20 }

  has_many :order_items
  has_many :orders, through: :order_items
  
  belongs_to :supplier
end
