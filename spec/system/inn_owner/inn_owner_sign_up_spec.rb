require 'rails_helper'


describe 'Inn owner sign up' do
  context 'authentication' do
    it 'create new account' do
      visit root_path
      click_on 'Gestão de Pousadas'
      click_on 'Criar nova conta'
      fill_in 'Nome', with: 'João'
      fill_in 'Sobrenome', with: 'Almeida'
      fill_in 'CPF', with: '53783222001'
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      fill_in 'Nome Fantasia', with: 'Pousada do Almeidinha'
      fill_in 'CNPJ', with: '30638898000199'
      click_on 'Cadastrar'

      expect(page).to have_content ' Você realizou seu registro com sucesso'
      expect(page).to have_content 'Continue o cadastro de sua pousada...'
    end

    it 'inn registration number must be unique' do
      inn_owner = InnOwner.create!(first_name: 'Erika', last_name: 'Campos', 
                                   document: '69174680889', email: 'erika@email.com', password: '123456')
      inn_owner.create_inn!(name: 'Pousada da Erika', registration_number: '30638898000199')

      visit root_path
      click_on 'Gestão de Pousadas'
      click_on 'Criar nova conta'
      fill_in 'Nome', with: 'João'
      fill_in 'Sobrenome', with: 'Almeida'
      fill_in 'CPF', with: '53783222001'
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      fill_in 'Nome Fantasia', with: 'Pousada do Almeidinha'
      fill_in 'CNPJ', with: '30638898000199'
      click_on 'Cadastrar'

      expect(page).to have_content 'CNPJ já está em uso'
    end
  end

  context 'inn registration' do

    it 'and finish inn registration' do
      inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                   document: '53783222001', email: 'joao@email.com', password: '123456')
      inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199')

      visit root_path
      click_on 'Gestão de Pousadas'
      click_on 'Entrar'
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'

      fill_in 'Descrição', with: 'Pousada ideal para um fim de semana longe da rotina...'
      fill_in 'CEP', with: '01001-001'
      fill_in 'Endereço', with: 'Praça da Sé'
      fill_in 'Número', with: '100'
      fill_in 'Bairro', with: 'Centro'
      fill_in 'Cidade', with: 'São Paulo'
      select 'SP', from: 'Estado'
      click_on 'Atualizar Pousada'

      inn = inn_owner.inn.reload
      expect(current_path).to eq inn_management_path
      expect(inn.description).to eq 'Pousada ideal para um fim de semana longe da rotina...'
      expect(inn.full_address).to eq 'Praça da Sé, 100 - Centro - São Paulo/SP'
    end

    it 'fields are mandatory' do
      inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                   document: '53783222001', email: 'joao@email.com', password: '123456')
      inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199')

      visit root_path
      click_on 'Gestão de Pousadas'
      click_on 'Entrar'
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'

      fill_in 'Descrição', with: ''
      fill_in 'CEP', with: ''
      fill_in 'Endereço', with: ''
      fill_in 'Número', with: ''
      fill_in 'Bairro', with: ''
      fill_in 'Cidade', with: ''
      select 'SP', from: 'Estado'
      click_on 'Atualizar Pousada'

      expect(page).to have_css 'div.alert', text: 'Não foi possível gravar pousada: 6 erros'
    end
  end
end