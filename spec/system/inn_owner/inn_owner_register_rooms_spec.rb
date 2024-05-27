require 'rails_helper'

describe 'Inn owner register room' do
  it 'successfully' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Cadastrar Quarto'
    fill_in 'Nome', with: 'Quarto com varanda'
    fill_in 'Dimensão (m2)', with: '30'
    fill_in 'Máximo de Hóspedes', with: '3'
    fill_in 'Valor Diária', with: '200'

    click_on 'Criar Quarto'

    inn.reload
    expect(page).to have_css 'div.alert', text: 'Quarto cadastrado com sucesso'
    expect(page).to have_content 'Quarto com varanda'
    expect(page).to have_content 'Diária: R$ 200,00'
    expect(inn.inn_rooms.count).to eq 1
  end

  it 'and add photo' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Cadastrar Quarto'
    fill_in 'Nome', with: 'Quarto com varanda'
    fill_in 'Dimensão (m2)', with: '30'
    fill_in 'Máximo de Hóspedes', with: '3'
    fill_in 'Valor Diária', with: '200'
    attach_file 'Foto', Rails.root.join('spec/support/files/inn_room.jpg')

    click_on 'Criar Quarto'

    inn.reload
    expect(page).to have_css 'div.alert', text: 'Quarto cadastrado com sucesso'
    expect(page).to have_content 'Quarto com varanda'
    expect(page).to have_content 'Diária: R$ 200,00'
    expect(page).to have_css 'img[src$="inn_room.jpg"]'
    expect(inn.inn_rooms.count).to eq 1
  end

  it 'and fill in all fields' do 
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Cadastrar Quarto'
    fill_in 'Nome', with: ''
    fill_in 'Dimensão (m2)', with: ''
    fill_in 'Máximo de Hóspedes', with: ''

    click_on 'Criar Quarto'

    inn.reload
    expect(page).to have_css 'div.alert', text: 'Não foi possível gravar quarto: 3 erros'
  end

  it 'and view room details' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    first_room = inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 4)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Quarto Térreo'

    expect(page).to have_css 'h1', text: 'Quarto Térreo'
    expect(page).to have_content 'Nenhuma foto cadastrada'
    expect(page).to have_content 'Dimensão (m2): 30'
    expect(page).to have_content 'Máximo de Hóspedes: 3'
    expect(page).to have_link 'Editar', href: edit_inn_dashboard_inn_room_path(first_room)
  end
end