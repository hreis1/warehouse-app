require "rails_helper"

describe 'User sign in' do
  it 'successfully' do
    User.create!(email:'joao@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: '123456'
    within 'form' do
     click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    within 'nav' do
      expect(page).not_to have_link('Entrar')
      expect(page).to have_link('Sair')
      expect(page).to have_content('joao@email.com')
    end
  end
end