require 'rails_helper'

describe 'Inn owner manage inn' do
  it 'view inn after login' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    
    expect(page).to have_content 'Pousada do Almeidinha'
    expect(page).to have_content 'CNPJ: 30638898000199'
  end


  it 'and view rooms' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                    address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
          
    first_room = inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)
    second_room = inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    
    expect(page).to have_link 'Quarto Térreo', href: inn_dashboard_inn_room_path(first_room)
    expect(page).to have_link 'Quarto com Varanda', href: inn_dashboard_inn_room_path(second_room)
  end

end