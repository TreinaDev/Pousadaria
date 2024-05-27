require 'rails_helper'

describe 'Inn Owner edit inn' do

  it 'and update address' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                 document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Editar'

    fill_in 'Nome', with: 'Pousada Palace'
    fill_in 'Descrição', with: 'Um hotel famoso'
    fill_in 'CEP', with: '22021001'
    fill_in 'Endereço', with: 'Av Atlantica'
    fill_in 'Número', with: '1702'
    fill_in 'Bairro', with: 'Copacabana'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    select 'RJ', from: 'Estado'
    click_on 'Atualizar Pousada'

    expect(page).to have_content 'Pousada atualizada com sucesso'
    expect(page).to have_content 'Pousada Palace'
    expect(page).to have_content 'Av Atlantica, 1702 - Copacabana - Rio de Janeiro/RJ'
  end

  it 'fields are mandatory' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                 document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Editar'

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