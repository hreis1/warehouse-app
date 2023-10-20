require "rails_helper"

describe "User register product model" do
  it "if logged in" do

    visit new_product_model_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "successfully" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com")
    Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@samsung.com")
    
    visit root_path
    click_on "Modelos de Produtos"
    click_on "Cadastrar Modelo de Produto"
    fill_in "Nome", with: "Iphone 11"
    fill_in "Peso", with: "194"
    fill_in "Altura", with: "150"
    fill_in "Largura", with: "75"
    fill_in "Profundidade", with: "8"
    fill_in "SKU", with: "IPHONE-123"
    select "Apple", from: "Fornecedor"
    click_on "Cadastrar Modelo de Produto"

    expect(current_path).to eq(product_model_path(ProductModel.last))
    expect(page).to have_content("Modelo de Produto cadastrado com sucesso")
    expect(page).to have_content("Iphone 11")
    expect(page).to have_content("SKU: IPHONE-123")
    expect(page).to have_content("Dimensões: 150cm x 75cm x 8cm")
    expect(page).to have_content("Peso: 194g")
    expect(page).to have_content("Fornecedor: Apple")
    expect(page).to have_content("Modelo de Produto cadastrado com sucesso")
    expect(page).to have_link("Voltar")
  end

  it "and must fill in all fields" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path
    click_on "Modelos de Produtos"
    click_on "Cadastrar Modelo de Produto"
    fill_in "Nome", with: ""
    fill_in "Peso", with: ""
    fill_in "Altura", with: ""
    fill_in "Largura", with: ""
    fill_in "Profundidade", with: ""
    fill_in "SKU", with: ""

    click_on "Cadastrar Modelo de Produto"

    expect(page).to have_content("Não foi possível cadastrar o Modelo de Produto")
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Peso não pode ficar em branco")
    expect(page).to have_content("Altura não pode ficar em branco")
    expect(page).to have_content("Largura não pode ficar em branco")
    expect(page).to have_content("Profundidade não pode ficar em branco")
    expect(page).to have_content("SKU não pode ficar em branco")
    expect(page).to have_content("Fornecedor é obrigatório(a)")
  end
end