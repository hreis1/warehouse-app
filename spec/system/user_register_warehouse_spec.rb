require "rails_helper"

describe "Warehouse registration" do
  it "from home page" do

    visit root_path
    click_on "Cadastrar Galpão"

    expect(current_path).to eq(new_warehouse_path)
    expect(page).to have_field("Nome")
    expect(page).to have_field("Código")
    expect(page).to have_field("Cidade")
    expect(page).to have_field("Área")
    expect(page).to have_field("Endereço")
    expect(page).to have_field("CEP")
    expect(page).to have_field("Descrição")
    expect(page).to have_button("Criar Galpão")
  end
  
  it "successfully" do

    visit root_path
    click_on "Cadastrar Galpão"

    fill_in "Nome", with: "Galpão 1"
    fill_in "Código", with: "ABC"
    fill_in "Cidade", with: "Cidade A"
    fill_in "Área", with: "1000"
    fill_in "Endereço", with: "Rua A, 100"
    fill_in "CEP", with: "00000-000"
    fill_in "Descrição", with: "Galpão com 1000m²"

    click_on "Criar Galpão"

    expect(page).to have_content("Galpão cadastrado com sucesso!")
    expect(current_path).to eq root_path
    expect(page).to have_content("Galpão 1")
    expect(page).to have_content("ABC")
    expect(page).to have_content("Cidade A")
    expect(page).to have_content("1000 m²")
  end

  it "and must fill in all fields" do

    visit root_path
    click_on "Cadastrar Galpão"

    fill_in "Nome", with: ""
    fill_in "Código", with: ""
    fill_in "Cidade", with: ""
    fill_in "Área", with: ""
    fill_in "Endereço", with: ""
    fill_in "CEP", with: ""
    fill_in "Descrição", with: ""

    click_on "Criar Galpão"

    expect(page).to have_content("Galpão não cadastrado")
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Código não pode ficar em branco")
    expect(page).to have_content("Cidade não pode ficar em branco")
    expect(page).to have_content("Área não pode ficar em branco")
    expect(page).to have_content("Endereço não pode ficar em branco")
    expect(page).to have_content("CEP não pode ficar em branco")
    expect(page).to have_content("Descrição não pode ficar em branco")
  end
end