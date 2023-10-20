# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Warehouse.create!(name: "Galpão 1", code: "ABC", city: "Cidade 1" , area: 10_000, address: "Rua 1, 123", cep: "12345-123", description:"Galpão com 10.000 m² de área total, sendo 8.000 m² de área de armazenagem e 2.000 m² de área administrativa.")
Warehouse.create!(name: "Galpão 2", code: "DEF", city: "Cidade 2" , area: 20_000, address: "Rua 2, 456", cep: "12345-456", description:"Galpão com 20.000 m² de área total, sendo 16.000 m² de área de armazenagem e 4.000 m² de área administrativa.")
Warehouse.create!(name: "Galpão 3", code: "GHI", city: "Cidade 3" , area: 30_000, address: "Rua 3, 789", cep: "12345-789", description:"Galpão com 30.000 m² de área total, sendo 24.000 m² de área de armazenagem e 6.000 m² de área administrativa.")

Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com")
Supplier.create!(corporate_name: "Fornecedor DEF", brand_name: "DEF", registration_number: "1234567891012", full_address: "Rua das Palmeiras, 123", city: "Cidade 2", state: "CD", email: "contato@def.com")
Supplier.create!(corporate_name: "Fornecedor GHI", brand_name: "GHI", registration_number: "1234567891013", full_address: "Rua das Tulipas, 123", city: "Cidade 3", state: "EF", email: "contato@ghi.com")

apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891012", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com")
samsung = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891013", full_address: "Rua das Flores, 789", city: "Cidade 3", state: "EF", email: "contato@samsung.com")
ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 8,sku: "IPHONE-123" ,supplier: apple)
ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 7,sku: "SAMSUNG-123" ,supplier: samsung)

User.create!(email:'ana@email.com', password:'123456')
User.create!(email:'bea@email.com', password:'123456')