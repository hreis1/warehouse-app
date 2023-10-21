require "rails_helper"

describe "User registers supplier" do
  it 'if logged in' do

    visit new_supplier_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  it "from index page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path

    click_on "Fornecedores"
    click_on "Cadastrar fornecedor"

    expect(current_path).to eq new_supplier_path
    expect(page).to have_field("Nome Fantasia")
    expect(page).to have_field("Razão Social")
    expect(page).to have_field("CNPJ")
    expect(page).to have_field("Endereço")
    expect(page).to have_field("Cidade")
    expect(page).to have_field("Estado")
    expect(page).to have_field("Email")
  end

  it "successfully" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    visit root_path

    click_on "Fornecedores"
    click_on "Cadastrar fornecedor"

    fill_in "Razão Social", with: "Fornecedor ABC"
    fill_in "Nome Fantasia", with: "ABC"
    fill_in "CNPJ", with: "1234567891011"
    fill_in "Endereço", with: "Rua das Flores, 123"
    fill_in "Cidade", with: "Cidade 1"
    fill_in "Estado", with: "AB"
    fill_in "Email", with: "contato@abc.com"
    fill_in "Telefone", with: "11999999999"

    click_on "Cadastrar Fornecedor"

    expect(current_path).to eq supplier_path(Supplier.last.id)
    expect(page).to have_content("Fornecedor cadastrado com sucesso")
    expect(page).to have_content("Fornecedor ABC")
    expect(page).to have_content("Documento: 1234567891011")
    expect(page).to have_content("Endereço: Rua das Flores, 123 - Cidade 1 - AB")
    expect(page).to have_content("Email: contato@abc.com")
    expect(page).to have_content("Telefone: 11999999999")
  end

  it "and attributes must be filled" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)
    
    visit root_path

    click_on "Fornecedores"
    click_on "Cadastrar fornecedor"

    fill_in "Razão Social", with: ""
    fill_in "Nome Fantasia", with: ""
    fill_in "CNPJ", with: ""
    fill_in "Endereço", with: ""
    fill_in "Cidade", with: ""
    fill_in "Estado", with: ""
    fill_in "Email", with: ""
    fill_in "Telefone", with: ""

    click_on "Cadastrar Fornecedor"

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