def login(user)
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  within 'form' do
    click_button 'Entrar'
  end
end