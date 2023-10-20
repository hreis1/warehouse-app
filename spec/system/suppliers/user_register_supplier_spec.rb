require "rails_helper"

describe "User registers supplier" do
  it "from index page" do
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

    click_on "Criar Fornecedor"

    expect(current_path).to eq supplier_path(Supplier.last.id)
    expect(page).to have_content("Fornecedor cadastrado com sucesso")
    expect(page).to have_content("Fornecedor ABC")
    expect(page).to have_content("Documento: 1234567891011")
    expect(page).to have_content("Endereço: Rua das Flores, 123 - Cidade 1 - AB")
    expect(page).to have_content("Email: contato@abc.com")
  end

  it "and attributes must be filled" do
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

    click_on "Criar Fornecedor"

    expect(page).to have_content("Razão Social não pode ficar em branco")
    expect(page).to have_content("Nome Fantasia não pode ficar em branco")
    expect(page).to have_content("CNPJ não pode ficar em branco")
    expect(page).to have_content("Endereço não pode ficar em branco")
    expect(page).to have_content("Cidade não pode ficar em branco")
    expect(page).to have_content("Estado não pode ficar em branco")
    expect(page).to have_content("Email não pode ficar em branco")
  end
end