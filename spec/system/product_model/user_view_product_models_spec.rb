require "rails_helper"

describe "User view product models" do
  it "from home page" do
    
    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(product_models_path)
  end

  it "successfully" do
    Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891012", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com")
    Supplier.create!(corporate_name: "Samsung", brand_name: "Samsung", registration_number: "1234567891013", full_address: "Rua das Flores, 789", city: "Cidade 3", state: "EF", email: "contato@samsung.com")

    ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 8,sku: "IPHONE-123" ,supplier: Supplier.first)
    ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 7,sku: "SAMSUNG-123" ,supplier: Supplier.last)

    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(product_models_path)
    expect(page).to have_content("Iphone 11")
    expect(page).to have_content("IPHONE-123")
    expect(page).to have_content("Apple")

    expect(page).to have_content("S10")
    expect(page).to have_content("SAMSUNG-123")
    expect(page).to have_content("Samsung")
  end

  it "and sees message if there is no product model" do
    
    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq(product_models_path)
    expect(page).to have_content("Nenhum modelo de produto cadastrado")
  end
end