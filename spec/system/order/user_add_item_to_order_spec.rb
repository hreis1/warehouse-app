require "rails_helper"

describe 'User add item to order' do
  it "and must be logged in" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    product1 = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit new_order_order_item_path(Order.last)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    product1 = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)
    product2 = ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 1,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: supplier)

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select "#{product1.name}", from: 'Produto'
    fill_in 'Quantidade', with: 10
    click_on 'Cadastrar Item do Pedido'

    expect(page).to have_content('Item adicionado com sucesso')
    expect(page).to have_content("10 x #{product1.name}")
    expect(page).not_to have_content("#{product2.name}")
  end

  it 'and must fill all fields' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    product1 = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    click_on 'Cadastrar Item do Pedido'

    expect(page).to have_content('Não foi possível adicionar o item')
    expect(page).to have_content('Verifique os seguintes erros:')
    expect(page).to have_content('Produto é obrigatório(a)')
    expect(page).to have_content('Quantidade não pode ficar em branco')
  end

  it "and no sees products from other suppliers" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier1 = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")
    supplier2 = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@samsung.com", phone: "21999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    product1 = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier1)
    product2 = ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 1,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: supplier2)

    order = Order.create!(supplier: supplier1, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content("#{product1.name}")
    expect(page).not_to have_content("#{product2.name}")
  end

  it "and must be owner of the order" do
    user1 = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    user2 = User.create!(name: "Beltrano Fulano", email: "bf@email.com", password: "123456")
    login_as(user2)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    order1 = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user1)

    visit new_order_order_item_path(order1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Você não tem permissão para acessar essa página")
  end
end