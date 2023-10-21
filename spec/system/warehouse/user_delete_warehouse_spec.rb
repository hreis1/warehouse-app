require "rails_helper"

describe "User deletes warehouse" do
  it 'if logged in' do
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    visit warehouse_path(Warehouse.last)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  it 'successfully' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    visit root_path
    click_on 'Galpão 1'
    click_on 'Deletar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão deletado com sucesso!')
    expect(page).not_to have_content('Galpão 1')
    expect(page).not_to have_content('ABC')
    expect(page).not_to have_content('Cidade A')
    expect(page).not_to have_content('1000 m²')
  end

  it 'and keep another warehouses' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '12345-678')

    visit root_path
    click_on 'Galpão 1'
    click_on 'Deletar'
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão deletado com sucesso!')
    expect(page).not_to have_content('Galpão 1')
    expect(page).not_to have_content('ABC')
    expect(page).not_to have_content('Cidade A')
    expect(page).not_to have_content('1000 m²')
    expect(page).to have_content('Galpão 2')
    expect(page).to have_content('DEF')
    expect(page).to have_content('Cidade B')
    expect(page).to have_content('2000 m²')
  end
end