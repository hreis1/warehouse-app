require "rails_helper"

describe "User view product models" do
  it "if logged in" do

    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "from home page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(product_models_path)
  end

  it "successfully" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
    Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891012", full_address: "Rua das Flores, 789", city: "Cidade 3", state: "EF", email: "contato@samsung.com", phone: "21999999999")

    ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 8,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: Supplier.first)
    ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 7,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: Supplier.last)

    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(product_models_path)
    expect(page).to have_content("Iphone 11")
    expect(page).to have_content("IPHONEABCDEFGHIJKLNM")
    expect(page).to have_content("Apple")

    expect(page).to have_content("S10")
    expect(page).to have_content("SAMSUNGABCDEFGHIJKLM")
    expect(page).to have_content("Samsung")
  end

  it "and sees message if there is no product model" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    
    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(product_models_path)
    expect(page).to have_content("Nenhum modelo de produto cadastrado")
  end
end