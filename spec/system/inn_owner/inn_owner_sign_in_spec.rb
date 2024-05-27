require 'rails_helper'


describe 'Inn owner sign in' do

  it 'successfully' do
    inn_owner = InnOwner.create!(first_name: 'Erika', last_name: 'Campos', 
                                document: '69174680889', email: 'erika@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada da Erika', registration_number: '30638898000199')

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Entrar'
    fill_in 'E-mail', with: 'erika@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    within('nav#top-nav') do
      expect(page).to have_content 'erika@email.com'
      expect(page).to have_button 'Sair'
    end
  end

end