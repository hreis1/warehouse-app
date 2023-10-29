require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'attributes cannot be blank' do
      order = Order.new

      order.valid?
      expect(order.errors.include?(:supplier)).to be true
      expect(order.errors[:estimated_delivery_date]).to include('não pode ficar em branco')
      expect(order.errors[:supplier]).to include('é obrigatório(a)')
      expect(order.errors[:warehouse]).to include('é obrigatório(a)')
    end
    it 'code cannot be blank' do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      order = Order.new(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user)
      expect(order.code).to be_nil
      order.valid?
      expect(order.code).not_to be_empty
    end
    it 'estimated_delivery_date cannot be in the past' do
      order = Order.new(estimated_delivery_date: Date.today.prev_day)

      order.valid?
      expect(order.errors[:estimated_delivery_date]).to include('deve ser no futuro')
    end
    
    it 'estimated_delivery_date must be in the future' do
      order = Order.new(estimated_delivery_date: Date.today.next_day)

      order.valid?
      expect(order.errors[:estimated_delivery_date]).to be_empty
    end

    it 'estimated_delivery_date cannot be today' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?
      expect(order.errors[:estimated_delivery_date]).to include('deve ser no futuro')
    end
  end
  describe 'generate random code' do
    it 'when create a new order' do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      order = Order.new(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user) 
      order.save!
      expect(order.code).not_to be_empty
      expect(order.code.size).to eq(10)
    end

    it 'code must be unique' do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      warehouse2 = Warehouse.create!(name: 'Galpão B', code: 'DEF', city: 'Cidade B', area: '2000', address: 'Rua B', cep: '87654321', description: 'Galpão com 2000m²')
      order = Order.new(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user) 
      order.save!
      order2 = Order.new(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user)
      order2.save!

      expect(order2.code).not_to eq(order.code)
    end

    it 'code is generated only when the order is created' do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      warehouse2 = Warehouse.create!(name: 'Galpão B', code: 'DEF', city: 'Cidade B', area: '2000', address: 'Rua B', cep: '87654321', description: 'Galpão com 2000m²')
      order = Order.new(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user) 
      order.save!
      original_code = order.code

      order.update!(warehouse: warehouse2)
      expect(order.code).to eq(original_code)
    end
  end
end
