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