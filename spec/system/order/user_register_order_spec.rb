require "rails_helper"

describe 'User register order' do
  it 'if not logged in' do
    
    visit new_order_path

    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Pedras, 456", city: "Cidade 2", state: "CD", email: "contato@samsung.com", phone: "21999999999")
    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '87654-321')
    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')

    visit root_path
    click_on 'Registrar Pedido'
    estimated_delivery_date = Date.today.next_day.strftime('%d/%m/%Y')
    fill_in 'Data de entrega estimada', with: estimated_delivery_date
    select supplier.corporate_name, from: 'Fornecedor'
    select 'ABC - Galpão 1', from: 'Galpão Destino'
    click_on 'Cadastrar'

    expect(current_path).to eq(order_path(Order.last))
    expect(page).to have_content('Pedido registrado com sucesso!')
    expect(page).to have_content('Código: ABC1234567')
    expect(page).to have_content('Galpão Destino: Galpão 1')
    expect(page).to have_content('Fornecedor: Apple')
    expect(page).to have_content('Situação do Pedido: Pendente')
    expect(page).to have_content('Data de entrega estimada: ' + estimated_delivery_date)
    expect(page).to have_content('Usuário Responsável: Fulano Sicrano - fs@email')
    expect(page).not_to have_content('Galpão 2')
    expect(page).not_to have_content('Samsung')
  end

  it 'and must fill in all fields' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path
    click_on 'Registrar Pedido'
    click_on 'Cadastrar'
    
    expect(current_path).to eq(orders_path)
    expect(page).to have_content('Verifique os seguintes erros:')
    expect(page).to have_content('Data de entrega estimada não pode ficar em branco')
  end
end