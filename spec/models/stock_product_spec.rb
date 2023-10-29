require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "#valid?" do
    it "serial number can't be blank" do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      product_model = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      order = Order.create!(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user)
      order_item = OrderItem.create!(order: order, product_model: product_model, quantity: 10)
      stock_product = StockProduct.new(order: order, warehouse: warehouse, product_model: product_model)
      expect(stock_product.serial_number).to eq(nil)

      stock_product.valid?

      expect(stock_product.serial_number).to_not eq(nil)
    end
  end    

  describe "generate serial number" do
    it "when create a new stock product" do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      product_model = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      order = Order.create!(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user)
      order_item = OrderItem.create!(order: order, product_model: product_model, quantity: 10)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_model)

      expect(stock_product.serial_number.length).to eq(20)
    end

    it "serial number is not modified when stock product is updated" do
      user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
      supplier = Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
      product_model = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)
      warehouse = Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      warehouse2 = Warehouse.create!(name: 'Galpão B', code: 'DEF', city: 'Cidade B', area: '2000', address: 'Rua B', cep: '87654321', description: 'Galpão com 2000m²')
      order = Order.create!(estimated_delivery_date: Date.today.next_day, supplier: supplier, warehouse: warehouse, user: user) 
      order_item = OrderItem.create!(order: order, product_model: product_model, quantity: 10)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_model)
      original_serial_number = stock_product.serial_number
      stock_product.update!(warehouse: warehouse2)

      expect(stock_product.serial_number).to eq(original_serial_number)
    end
  end
end