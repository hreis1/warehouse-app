require "rails_helper"

describe "User view own orders" do
  it "and must be logged in" do
    visit root_path

    expect(page).not_to have_link("Meus Pedidos")
    expect(current_path).to eq(new_user_session_path)
  end

  it "successfully" do
    user1 = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    user2 = User.create!(name: "Beltrano Fulano", email: "bf@email.com", password: "123456")

    login_as(user1)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse1 = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    warehouse2 = Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '12345-678')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123', 'ABC456', 'DEF123')
    order1 = Order.create!(supplier: supplier, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user1)
    order2 = Order.create!(supplier: supplier, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user2)
    order3 = Order.create!(supplier: supplier, warehouse: warehouse2, estimated_delivery_date: Date.today.next_day, user: user2)

    visit root_path
    click_on "Meus Pedidos"

    expect(page).to have_content("Meus Pedidos")
    expect(page).to have_content("Código: #{order1.code}")
    expect(page).to have_content("Fornecedor: #{order1.supplier.corporate_name}")
    expect(page).to have_content("Galpão Destino: #{order1.warehouse.name}")
    expect(page).to have_content("Data de entrega estimada: #{order1.estimated_delivery_date.strftime('%d/%m/%Y')}")
    expect(page).not_to have_content("Código: #{order2.code}")
    expect(page).not_to have_content("Código: #{order3.code}")
  end
end