require "rails_helper"

describe "User edit warehouse" do
  it 'from show page' do
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    visit root_path
    click_on 'Galpão 1'
    click_on 'Editar'

    expect(current_path).to eq(edit_warehouse_path(Warehouse.last))
    expect(page).to have_field('Nome', with: 'Galpão 1')
    expect(page).to have_field('Código', with: 'ABC')
    expect(page).to have_field('Cidade', with: 'Cidade A')
    expect(page).to have_field('Área', with: '1000')
    expect(page).to have_field('Endereço', with: 'Rua 1')
    expect(page).to have_field('CEP', with: '12345-678')
    expect(page).to have_field('Descrição', with: 'Galpão com 1000m²')
    expect(page).to have_button('Atualizar Galpão')
  end

  it 'successfully' do
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    visit root_path
    click_on 'Galpão 1'
    click_on 'Editar'

    fill_in 'Nome', with: 'Galpão 2'
    fill_in 'Código', with: 'DEF'
    fill_in 'Cidade', with: 'Cidade B'
    fill_in 'Área', with: '2000'
    fill_in 'Endereço', with: 'Rua 2'
    fill_in 'CEP', with: '98765-432'
    fill_in 'Descrição', with: 'Galpão com 2000m²'
    click_on 'Atualizar Galpão'

    expect(current_path).to eq(warehouse_path(Warehouse.last))
    expect(page).to have_content('Galpão atualizado com sucesso!')
    expect(page).to have_content('Galpão 2')
    expect(page).to have_content('DEF')
    expect(page).to have_content('Cidade B')
    expect(page).to have_content('2000')
    expect(page).to have_content('Rua 2')
    expect(page).to have_content('98765-432')
    expect(page).to have_content('Galpão com 2000m²')
    expect(page).to have_link('Voltar')
  end

  it 'and must fill all fields' do
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    visit root_path
    click_on 'Galpão 1'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Atualizar Galpão'

    expect(page).to have_content('Galpão não atualizado')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Área não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end

  it 'and code must be unique' do
    Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')
    Warehouse.create!(name: 'Galpão 2', code: 'DEF', address: 'Rua 2', area: 2000, city: 'Cidade B', description: 'Galpão com 2000m²', cep: '98765-432')

    visit root_path
    click_on 'Galpão 1'
    click_on 'Editar'

    fill_in 'Código', with: 'DEF'
    click_on 'Atualizar Galpão'

    expect(page).to have_content('Galpão não atualizado')
    expect(page).to have_content('Código já está em uso')
  end
end