require "rails_helper"

describe "User views suppliers" do
  it 'if logged in' do
    
    visit root_path
    within "nav" do
      click_on "Fornecedores"
    end

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "from index page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path

    within "nav" do
      click_on "Fornecedores"
    end

    expect(current_path).to eq suppliers_path
  end

  it "successfully" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    Supplier.create!(corporate_name: "Fornecedor ABC", brand_name: "ABC", registration_number: "1234567891011", full_address: "Rua das Flores, 123", city: "Cidade 1", state: "AB", email: "contato@abc.com", phone: "11999999999")
    Supplier.create!(corporate_name: "Fornecedor DEF", brand_name: "DEF", registration_number: "1234567891012", full_address: "Rua das Palmeiras, 123", city: "Cidade 2", state: "CD", email: "contato@def.com", phone: "12999999999")

    visit root_path
    
    within "nav" do
      click_on "Fornecedores"
    end

    expect(current_path).to eq suppliers_path
    expect(page).not_to have_content("Nenhum fornecedor cadastrado")
    expect(page).to have_content("ABC")
    expect(page).to have_content("Cidade 1 - AB")
    expect(page).to have_content("DEF")
    expect(page).to have_content("Cidade 2 - CD")
  end

  it "and sees a message if there are no suppliers" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    visit root_path

    within "nav" do
      click_on "Fornecedores"
    end

    expect(current_path).to eq suppliers_path
    expect(page).to have_content("Nenhum fornecedor cadastrado")
  end
end