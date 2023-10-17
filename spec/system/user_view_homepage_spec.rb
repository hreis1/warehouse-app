require "rails_helper"

describe "User views homepage" do
  it "and sees a name of the app" do
    
    visit root_path

    expect(page).to have_content("Galpões & Estoque")
  end

  it "and sees a list of warehouses" do
    
    Warehouse.create!(name: "Galpão 1", code: "ABC", city: "Cidade 1" , area: 10_000)
    Warehouse.create!(name: "Galpão 2", code: "DEF", city: "Cidade 2" , area: 20_000)

    visit root_path

    expect(page).not_to have_content("Nenhum galpão cadastrado")
    expect(page).to have_content("Galpão 1")
    expect(page).to have_content("Código: ABC")
    expect(page).to have_content("Cidade: Cidade 1")
    expect(page).to have_content("10000 m²")

    expect(page).to have_content("Galpão 2")
    expect(page).to have_content("Código: DEF")
    expect(page).to have_content("Cidade: Cidade 2")
    expect(page).to have_content("20000 m²")
  end

  it "and sees a message if there are no warehouses" do

    visit root_path

    expect(page).to have_content("Nenhum galpão cadastrado")
  end
end