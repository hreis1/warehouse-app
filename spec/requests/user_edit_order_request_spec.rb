require "rails_helper"

describe "User edit order" do
  it "and is not a user's order" do
    user1 = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    user2 = User.create!(name: "Beltrano Fulano", email: "bf@email.com", password: "123456")
    login_as(user1)

    supplier1 = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")
    supplier2 = Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@samsung", phone: "21999999999")

    warehouse1 = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    warehouse2 = Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '87654-321')

    order = Order.create!(supplier: supplier1, warehouse: warehouse1, estimated_delivery_date: Date.today.next_day, user: user1)
    order2 = Order.create!(supplier: supplier2, warehouse: warehouse2, estimated_delivery_date: Date.today.next_day, user: user2)

    patch order_path(order2), params: { order: { supplier_id: supplier1.id } }

    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq('Você não tem permissão para acessar essa página')
  end
end