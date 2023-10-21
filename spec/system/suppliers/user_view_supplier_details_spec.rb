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

  it "and sees products from supplier" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
    Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 789", city: "Cidade 3", state: "EF", email: "contato@samsung.com", phone: "21999999999")

    ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: Supplier.first)
    ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 1,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: Supplier.last)

    visit root_path
    click_on "Fornecedores"
    click_on "Apple"

    expect(current_path).to eq supplier_path(Supplier.first)
    expect(page).to have_content("Modelos de Produtos")
    expect(page).to have_content("Nome: Iphone 11")
    expect(page).to have_content("Dimensões: 150cm x 75cm x 1cm")
    expect(page).to have_content("Peso: 194g")
    expect(page).to have_content("SKU: IPHONEABCDEFGHIJKLNM")
    expect(page).not_to have_content("Nome: S10")
    expect(page).not_to have_content("Dimensões: 70cm x 150cm x 1cm")
    expect(page).not_to have_content("Peso: 157g")
    expect(page).not_to have_content("SKU: SAMSUNGABCDEFGHIJKLM")
  end
  
  it "and sees no products from supplier" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com" , phone: "11999999999")

    visit root_path
    click_on "Fornecedores"
    click_on "Apple"

    expect(current_path).to eq supplier_path(Supplier.first)
    expect(page).to have_content("Modelos de Produtos")
    expect(page).to have_content("Nenhum modelo de produto cadastrado")
  end
end