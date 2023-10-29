require "rails_helper"

describe "User edit own order" do
  it "and must be logged in" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)
    
    visit edit_order_path(order)

    expect(current_path).to eq new_user_session_path
  end

  it "successfully" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier1 = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")
    supplier2 = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@samsung", phone: "21999999999")

    warehouse1 = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    warehouse2 = Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '87654-321')

    order = Order.create!(supplier: supplier1, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on "Editar"

    fill_in "Data de entrega estimada", with: Date.today.next_day+1.day
    select "#{supplier2.corporate_name}", from: "Fornecedor"
    select "#{warehouse2.full_description}", from: "Galpão"
    click_on "Atualizar Pedido"

    expect(current_path).to eq(order_path(Order.last))
    expect(page).to have_content("Pedido atualizado com sucesso")
    expect(page).to have_content("Data de entrega estimada: #{(Date.today.next_day+1.day).strftime('%d/%m/%Y')}")
    expect(page).to have_content("Fornecedor: #{supplier2.corporate_name}")
    expect(page).to have_content("Galpão Destino: #{warehouse2.name}")
  end

  it "and must be user's order" do
    user1 = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    user2 = User.create!(name: "Beltrano Fulano", email: "bf@email.com", password: "123456")
    login_as(user1)

    supplier1 = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")
    supplier2 = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@samsung", phone: "21999999999")

    warehouse1 = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    warehouse2 = Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '87654-321')

    order = Order.create!(supplier: supplier1, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user1)
    order2 = Order.create!(supplier: supplier2, warehouse: warehouse2, estimated_delivery_date: Date.today.next_day, user: user2)

    visit edit_order_path(order2)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Você não tem permissão para acessar essa página")
  end

  it "and can't edit a delivered order" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)
    order.delivered!
    
    visit edit_order_path(order)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Você não tem permissão para acessar essa página")
  end
end