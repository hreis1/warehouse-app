class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :cep, :description, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 3 }
  validates :code, format: { with: /\A[A-Z]+\z/, message: 'only allows uppercase letters' }
  validates :area, numericality: { only_integer: true }
end
