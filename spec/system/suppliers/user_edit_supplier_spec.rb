require "rails_helper"

describe "User edits supplier" do
  it 'if logged in' do
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")

    visit edit_supplier_path(Supplier.last)
    
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "from home page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"
    click_on "Editar"

    expect(page).to have_field("Razão Social", with: "Fornecedor ABC")
    expect(page).to have_field("Nome Fantasia", with: "ABC")
    expect(page).to have_field("CNPJ", with: "1234567891011")
    expect(page).to have_field("Endereço", with: "Rua das Flores, 123")
    expect(page).to have_field("Cidade", with: "Cidade 1")
    expect(page).to have_field("Estado", with: "AB")
    expect(page).to have_field("Email", with: "contato@abc.com")
    expect(page).to have_field("Telefone", with: "11999999999")
    expect(page).to have_button("Atualizar Fornecedor")
  end

  it "successfully" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"
    click_on "Editar"

    fill_in "Razão Social", with: "Fornecedor DEF"
    fill_in "Nome Fantasia", with: "DEF"
    fill_in "CNPJ", with: "1234567891012"
    fill_in "Endereço", with: "Rua das Flores, 456"
    fill_in "Cidade", with: "Cidade 2"
    fill_in "Estado", with: "CD"
    fill_in "Email", with: "contato@cd.com"
    fill_in "Telefone", with: "22888888888"
    click_on "Atualizar Fornecedor"

    expect(current_path).to eq(supplier_path(Supplier.last))
    expect(page).to have_content("Fornecedor atualizado com sucesso")
    expect(page).to have_content("Fornecedor DEF")
    expect(page).to have_content("DEF")
    expect(page).to have_content("1234567891012")
    expect(page).to have_content("Rua das Flores, 456")
    expect(page).to have_content("Cidade 2")
    expect(page).to have_content("CD")
    expect(page).to have_content("contato@cd.com")
    expect(page).to have_content("22888888888")
  end

  it "and attributes cannot be blank" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")

    visit root_path
    click_on "Fornecedores"
    click_on "ABC"
    click_on "Editar"

    fill_in "Razão Social", with: ""
    fill_in "Nome Fantasia", with: ""
    fill_in "CNPJ", with: ""
    fill_in "Endereço", with: ""
    fill_in "Cidade", with: ""
    fill_in "Estado", with: ""
    fill_in "Email", with: ""
    fill_in "Telefone", with: ""
    click_on "Atualizar Fornecedor"

    expect(page).to have_content("Não foi possível atualizar o fornecedor")
    expect(page).to have_content("Razão Social não pode ficar em branco")
    expect(page).to have_content("Nome Fantasia não pode ficar em branco")
    expect(page).to have_content("CNPJ não pode ficar em branco")
    expect(page).to have_content("Endereço não pode ficar em branco")
    expect(page).to have_content("Cidade não pode ficar em branco")
    expect(page).to have_content("Estado não pode ficar em branco")
    expect(page).to have_content("Email não pode ficar em branco")
    expect(page).to have_content("Telefone não pode ficar em branco")
  end
end