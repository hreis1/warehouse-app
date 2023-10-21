class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :cep, :description, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: { is: 3 }
  validates :code, format: { with: /\A[A-Z]+\z/, message: 'somente letras maiúsculas' }
  validates :area, numericality: { only_integer: true }
  validates :cep, format: { with: /\A\d{5}-?\d{3}\z/, message: 'formato inválido' }
end
