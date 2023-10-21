require "rails_helper"

describe "User views homepage" do
  it 'if logged in' do

    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  it "and sees a name of the app" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    
    visit root_path

    expect(page).to have_content("Sistema de Galpões e Estoque")
  end

  it "and sees a list of warehouses" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Warehouse.create!(name: "Galpão 1", code: "ABC", city: "Cidade 1" , area: 10_000, address: "Rua A, 100", cep: "00000-000", description: "Galpão com 1000m²")
    Warehouse.create!(name: "Galpão 2", code: "DEF", city: "Cidade 2" , area: 20_000, address: "Rua B, 200", cep: "11111-111", description: "Galpão com 2000m²")

    visit root_path

    expect(page).not_to have_content("Nenhum galpão cadastrado")
    expect(page).to have_content("Galpão 1")
    expect(page).to have_content("Código: ABC")
    expect(page).to have_content("Cidade: Cidade 1")
    expect(page).to have_content("10000 m²")

    expect(page).to have_content("Galpão 2")
    expect(page).to have_content("Código: DEF")
    expect(page).to have_content("Cidade: Cidade 2")
    expect(page).to have_content("20000 m²")
  end

  it "and sees a message if there are no warehouses" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path

    expect(page).to have_content("Nenhum galpão cadastrado")
  end
end