require "rails_helper"

describe 'User sign up' do
  it 'successfully' do

    visit root_path
    click_on 'Criar conta'

    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'

    click_on 'Criar conta'

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_button('Sair')
    user = User.last
    expect(user.name).to eq('Maria')
  end

  it 'and must fill all fields' do

    visit root_path
    click_on 'Criar conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''

    click_on 'Criar conta'

    expect(page).to have_content('Não foi possível salvar usuário')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end
end