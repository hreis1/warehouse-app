require "rails_helper"

describe "User views supplier details" do
  it 'if logged in' do
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")
    
    visit supplier_path(Supplier.last)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "from home page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")
    Supplier.create!(corporate_name: "Fornecedor DEF", brand_name: "DEF", registration_number: "1234567891012", full_address: "Rua das Palmeiras, 123", city: "Cidade 2", state: "CD", email: "contato@def.com", phone: "11999999999")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"

    expect(page).to have_content("Fornecedor ABC")
    expect(page).to have_content("ABC")
    expect(page).to have_content("Documento: 1234567891011")
    expect(page).to have_content("Endereço: Rua das Flores, 123 - Cidade 1 - AB")
    expect(page).to have_content("Email: contato@abc.com")
    expect(page).to have_content("Telefone: 11999999999")
  end

  it "and return to view all suppliers" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"
    click_on "Voltar"

    expect(current_path).to eq suppliers_path
  end
end