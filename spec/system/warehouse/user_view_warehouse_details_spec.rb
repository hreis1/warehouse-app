require "rails_helper"

describe "User views warehouse details" do
  it "if logged in" do
    Warehouse.create!(name: "Galpão 1", code: "ABC", city: "Cidade 1" , area: 10_000, address: "Rua 1, 123", cep: "12345-123", description:"Galpão com 10.000 m² de área total, sendo 8.000 m² de área de armazenagem e 2.000 m² de área administrativa.")

    visit warehouse_path(Warehouse.last)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "and view additional warehouse information" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Warehouse.create!(name: "Galpão 1", code: "ABC", city: "Cidade 1" , area: 10_000, address: "Rua 1, 123", cep: "12345-123", description:"Galpão com 10.000 m² de área total, sendo 8.000 m² de área de armazenagem e 2.000 m² de área administrativa.")

    visit root_path
    click_on "Galpão 1"

    expect(page).to have_content("Galpão ABC")
    expect(page).to have_content("Descrição: Galpão com 10.000 m² de área total, sendo 8.000 m² de área de armazenagem e 2.000 m² de área administrativa.")
    expect(page).to have_content("Nome: Galpão 1")
    expect(page).to have_content("Cidade: Cidade 1")
    expect(page).to have_content("Área: 10000 m²")
    expect(page).to have_content("Endereço: Rua 1, 123 CEP: 12345-123")
  end

  it 'and return to home page' do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Warehouse.create!(name: "Galpão 1", code: "ABC", city: "Cidade 1" , area: 10_000, address: "Rua 1, 123", cep: "12345-123", description:"Galpão com 10.000 m² de área total, sendo 8.000 m² de área de armazenagem e 2.000 m² de área administrativa.")

    visit root_path
    click_on "Galpão 1"
    click_on "Voltar"

    expect(current_path).to eq root_path
  end
end