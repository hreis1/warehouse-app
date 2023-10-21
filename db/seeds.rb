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

apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
samsung = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 789", city: "Cidade 3", state: "EF", email: "contato@samsung.com", phone: "21999999999")
ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONE11ABCDEFGHIJKL" ,supplier: apple)
ProductModel.create!(name: "Iphone 12", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONE12ABCDEFGHIJKL" ,supplier: apple)
ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 7000,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: samsung)

User.create!(name: 'Ana', email:'ana@email.com', password:'123456')
User.create!(name: 'Beatriz', email:'bea@email.com', password:'123456')
User.create!(name: 'Fulano', email:'f@email.com', password:'123456')
User.create!(name: 'Sicrano', email:'s@email.com', password:'123456')