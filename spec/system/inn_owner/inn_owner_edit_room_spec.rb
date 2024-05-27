require 'rails_helper'

describe 'Inn owner edit room' do
  it 'successfully' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                    address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})


    edited_room = inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Quarto com Varanda'
    click_on 'Editar'
    fill_in 'Nome', with: 'Quarto com Sacada'
    fill_in 'Dimensão (m2)', with: '35'
    fill_in 'Máximo de Hóspedes', with: '4'
    attach_file 'Foto', Rails.root.join('spec/support/files/inn_room.jpg')
    click_on 'Atualizar Quarto'

    expect(current_path).to eq inn_dashboard_inn_room_path(edited_room)
    expect(page).to have_css 'div.alert', text: 'Quarto atualizado com sucesso'
    expect(page).to have_css 'h1', text: 'Quarto com Sacada'
    expect(page).to have_content 'Dimensão (m2): 35'
    expect(page).to have_content 'Máximo de Hóspedes: 4'
    expect(page).to have_css 'img[src$="inn_room.jpg"]'
  end


  it 'and fill in all fields' do 
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Quarto com Varanda'
    click_on 'Editar'
    fill_in 'Nome', with: 'Quarto com Varanda'
    fill_in 'Dimensão (m2)', with: '0'
    fill_in 'Máximo de Hóspedes', with: ''
    click_on 'Atualizar Quarto'
  
    expect(page).to have_css 'div.alert', text: 'Não foi possível gravar quarto: 2 erros'
  end
end