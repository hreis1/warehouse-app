# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Warehouse.create!(name: "Galpão ADN gerador", code: "ADN", area: 1000, address: "Rua das Flores, 123", city: "São Paulo", cep: "12345678", description: "Galpão de armazenamento de geradores")
Warehouse.create!(name: "Galpão SLV som", code: "SLV", area: 2000, address: "Avenida das Árvores, 456", city: "Rio de Janeiro", cep: "23456789", description: "Galpão de armazenamento de som")
Warehouse.create!(name: "Galpão MND móveis", code: "MND", area: 3000, address: "Alameda dos Anjos, 789", city: "Salvador", cep: "34567890", description: "Galpão de armazenamento de móveis")
Warehouse.create!(name: "Galpão ELT eletronicos", code: "ELT", area: 4000, address: "Praça das Pedras, 1011", city: "Belo Horizonte", cep: "45678901", description: "Galpão de armazenamento de eletronicos")

apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "São Paulo", state: "SP", email: "contato@apple.com", phone: "11999999999") 
samsung = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 789", city: "Rio de Janeiro", state: "RJ", email: "contato@samsung", phone: "21999999999")
xiaomi = Supplier.create!(corporate_name: "Xiaomi", brand_name: "Xiaomi", registration_number: "1234567891013", full_address: "Rua das Flores, 1011", city: "Salvador", state: "BA", email: "contato@xiaomi", phone: "31999999999")
lg = Supplier.create!(corporate_name: "LG", brand_name: "LG", registration_number: "1234567891014", full_address: "Rua das Flores, 1213", city: "Belo Horizonte", state: "MG", email: "contato@lg", phone: "41999999999")
motorola = Supplier.create!(corporate_name: "Motorola", brand_name: "Motorola", registration_number: "1234567891015", full_address: "Rua das Flores, 1415", city: "Santa Catarina", state: "SC", email: "contato@motorola", phone: "51999999999")
asus = Supplier.create!(corporate_name: "Asus", brand_name: "Asus", registration_number: "1234567891016", full_address: "Rua das Flores, 1617", city: "Curitiba", state: "PR", email: "contato@asus", phone: "61999999999")
lenovo = Supplier.create!(corporate_name: "Lenovo", brand_name: "Lenovo", registration_number: "1234567891017", full_address: "Rua das Flores, 1819", city: "Porto Alegre", state: "RS", email: "contato@lenovo", phone: "71999999999")
sony = Supplier.create!(corporate_name: "Sony", brand_name: "Sony", registration_number: "1234567891018", full_address: "Rua das Flores, 2021", city: "Manaus", state: "AM", email: "contato@sony", phone: "81999999999")
nokia = Supplier.create!(corporate_name: "Nokia", brand_name: "Nokia", registration_number: "1234567891019", full_address: "Rua das Flores, 2223", city: "Recife", state: "PE", email: "contato@nokia", phone: "91999999999")
google = Supplier.create!(corporate_name: "Google", brand_name: "Google", registration_number: "1234567891020", full_address: "Rua das Flores, 2425", city: "Fortaleza", state: "CE", email: "contato@google", phone: "10199999999")


ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONE11ABCDEFGHIJKL" ,supplier: apple)
ProductModel.create!(name: "Iphone 12", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONE12ABCDEFGHIJKL" ,supplier: apple)
ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 1,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: samsung)
ProductModel.create!(name: "S20", weight: 157, height: 70, width: 150, depth: 1,sku: "SAMSUNGABCDEFGHIJKL1" ,supplier: samsung)
ProductModel.create!(name: "Redmi 9", weight: 196, height: 75, width: 150, depth: 1,sku: "XIAOMIABCDEFGHIJKLMN" ,supplier: xiaomi)
ProductModel.create!(name: "Redmi 10", weight: 196, height: 75, width: 150, depth: 1,sku: "XIAOMIABCDEFGHIJKLM1" ,supplier: xiaomi)
ProductModel.create!(name: "K10", weight: 168, height: 75, width: 150, depth: 1,sku: "LGABCDEFGHIJKLMNOPQR" ,supplier: lg)
ProductModel.create!(name: "K11", weight: 168, height: 75, width: 150, depth: 1,sku: "LGABCDEFGHIJKLMNOPQ1" ,supplier: lg)
ProductModel.create!(name: "Moto G8", weight: 188, height: 75, width: 150, depth: 1,sku: "MOTOROLAABCDEFGHIJKL" ,supplier: motorola)
ProductModel.create!(name: "Moto G9", weight: 188, height: 75, width: 150, depth: 1,sku: "MOTOROLAABCDEFGHIJK1" ,supplier: motorola)
ProductModel.create!(name: "Zenfone 6", weight: 190, height: 75, width: 150, depth: 1,sku: "ASUSABCDEFGHIJKLMNOP" ,supplier: asus)
ProductModel.create!(name: "Zenfone 7", weight: 190, height: 75, width: 150, depth: 1,sku: "ASUSABCDEFGHIJKLMNO1" ,supplier: asus)
ProductModel.create!(name: "Vibe K6", weight: 140, height: 75, width: 150, depth: 1,sku: "LENOVOABCDEFGHIJKLMN" ,supplier: lenovo)
ProductModel.create!(name: "Vibe K7", weight: 140, height: 75, width: 150, depth: 1,sku: "LENOVOABCDEFGHIJKLM1" ,supplier: lenovo)
ProductModel.create!(name: "Xperia XZ", weight: 161, height: 75, width: 150, depth: 1,sku: "SONYABCDEFGHIJKLMNOP" ,supplier: sony)
ProductModel.create!(name: "Xperia XZ1", weight: 161, height: 75, width: 150, depth: 1,sku: "SONYABCDEFGHIJKLMNO1" ,supplier: sony)
ProductModel.create!(name: "Lumia 950", weight: 150, height: 75, width: 150, depth: 1,sku: "NOKIAABCDEFGHIJKLMNO" ,supplier: nokia)
ProductModel.create!(name: "Lumia 950XL", weight: 150, height: 75, width: 150, depth: 1,sku: "NOKIAABCDEFGHIJKLMN1" ,supplier: nokia)

User.create!(name: 'Ana', email:'ana@email.com', password:'123456')
User.create!(name: 'Beatriz', email:'bea@email.com', password:'123456')
User.create!(name: 'Fulano', email:'f@email.com', password:'123456')
User.create!(name: 'Sicrano', email:'s@email.com', password:'123456')