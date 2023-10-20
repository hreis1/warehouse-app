class ProductModel < ApplicationRecord
  validates :name, :sku, :weight, :height, :width, :depth, presence: true
  belongs_to :supplier
end
