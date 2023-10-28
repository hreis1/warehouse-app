require "rails_helper"

describe "User search order" do
  it "from home page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path

    within "header nav" do
      expect(page).to have_field("query", type: "text")
      expect(page).to have_button("Buscar")
    end
  end

  it "and he must be logged in" do
    visit root_path

    expect(page).not_to have_field("query", type: "text")
    expect(current_path).to eq(new_user_session_path)
  end

  it "and finds order by code" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    
    ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 8,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    fill_in "query", with: "ABC"
    click_on "Buscar"

    expect(page).to have_content("Resultados da busca por: ABC")
    expect(page).to have_content("1 pedido encontrado")

    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content("Fornecedor: #{order.supplier.corporate_name}")
    expect(page).to have_content("Galpão Destino: #{order.warehouse.name}")
    expect(page).to have_content("Data de entrega estimada: #{order.estimated_delivery_date.strftime('%d/%m/%Y')}")
  end

  it 'and finds many orders by code' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse1 = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    warehouse2 = Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '12345-678')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123', 'ABC456', 'DEF123')
    order1 = Order.create!(supplier: supplier, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user)
    order2 = Order.create!(supplier: supplier, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user)
    order3 = Order.create!(supplier: supplier, warehouse: warehouse2, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    fill_in "query", with: 'ABC'
    click_on "Buscar"

    expect(page).to have_content("Resultados da busca por: ABC")
    expect(page).to have_content("2 pedidos encontrados")
    expect(page).to have_content("Código: #{order1.code}")
    expect(page).to have_content("Código: #{order2.code}")
    expect(page).not_to have_content("Código: #{order3.code}")
  end

  it 'and not found order by code' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
    order1 = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    fill_in "query", with: 'DEF'
    click_on "Buscar"

    expect(page).to have_content("Resultados da busca por: DEF")
    expect(page).to have_content("0 pedidos encontrados")
    expect(page).not_to have_content("Código: ABC123")
  end

  it 'and blank search' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path
    fill_in "query", with: ''
    click_on "Buscar"

    expect(page).to have_content("Digite algo para buscar")
  end

  it 'and search exact code' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    order1 = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)
    order2 = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    fill_in "query", with: order1.code
    click_on "Buscar"

    expect(current_path).to eq(order_path(order1))
  end
end