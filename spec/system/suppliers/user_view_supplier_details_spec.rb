require "rails_helper"

describe "User views supplier details" do
  it "from home page" do
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com")
    Supplier.create!(corporate_name: "Fornecedor DEF", brand_name: "DEF", registration_number: "1234567891012", full_address: "Rua das Palmeiras, 123", city: "Cidade 2", state: "CD", email: "contato@def.com")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"

    expect(page).to have_content("Fornecedor ABC")
    expect(page).to have_content("ABC")
    expect(page).to have_content("Documento: 1234567891011")
    expect(page).to have_content("Endereço: Rua das Flores, 123 - Cidade 1 - AB")
    expect(page).to have_content("Email: contato@abc.com")
  end

  it "and return to view all suppliers" do
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"
    click_on "Voltar"

    expect(current_path).to eq suppliers_path
  end
end