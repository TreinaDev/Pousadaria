require 'rails_helper'

describe 'User visit home' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Pousadaria')
  end

  it 'and view inns' do
    owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    Inn.create!(name: 'Pousada dos Devs', inn_owner: owner, registration_number: '30638898000199')
    Inn.create!(name: 'Recanto dos Rubistas', inn_owner: owner, registration_number: '08397842000130')

    visit root_path
    
    within('section#inns') do
      expect(page).to have_content 'Pousada dos Devs'
      expect(page).to have_content 'Recanto dos Rubistas'
    end
  end

  it 'and view only active inns' do
    owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    Inn.create!(name: 'Pousada dos Devs', active: true, inn_owner: owner, registration_number: '30638898000199')
    Inn.create!(name: 'Recanto dos Rubistas', active: false, inn_owner: owner, registration_number: '08397842000130')

    visit root_path

    within('section#inns') do
      expect(page).to have_content 'Pousada dos Devs'
      expect(page).not_to have_content 'Pousada dos Rubistas'
    end
  end

  it 'and view rooms' do
    owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    inn = Inn.create!(name: 'Pousada dos Devs', active: true, inn_owner: owner, registration_number: '30638898000199', address: Address.new(address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'))
    Inn.create!(name: 'Recanto dos Rubistas', active: false, inn_owner: owner, registration_number: '08397842000130')

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    visit root_path
    click_on 'Pousada dos Devs'

    within('section#rooms') do
      expect(page).to have_content 'Quarto com Varanda'
      expect(page).to have_content 'Quarto Térreo'
    end
  end
end