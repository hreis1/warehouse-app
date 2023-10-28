require "rails_helper"

describe "User update order status" do
  it "and order status is delivered" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user, status: :pending)

    visit root_path
    click_on "Meus Pedidos"
    click_on "#{order.code}"
    click_on "Confirmar Entrega"

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Situação do Pedido: Entregue")
    expect(page).not_to have_button("Confirmar Entrega")
    expect(page).not_to have_button("Cancelar Pedido")
  end

  it "and order status is canceled" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user, status: :pending)

    visit root_path
    click_on "Meus Pedidos"
    click_on "#{order.code}"
    click_on "Cancelar Pedido"

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Situação do Pedido: Cancelado")
    expect(page).not_to have_button("Confirmar Entrega")
    expect(page).not_to have_button("Cancelar Pedido")
  end
end