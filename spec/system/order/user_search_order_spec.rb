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

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    visit root_path
    fill_in "query", with: order.code
    click_on "Buscar"

    expect(page).to have_content("Resultados da busca por: #{order.code}")
    expect(page).to have_content("1 pedido encontrado")

    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content("Fornecedor: #{order.supplier.corporate_name}")
    expect(page).to have_content("Galpão Destino: #{order.warehouse.name}")
    expect(page).to have_content("Data de entrega estimada: #{order.estimated_delivery_date.strftime('%d/%m/%Y')}")
  end
end