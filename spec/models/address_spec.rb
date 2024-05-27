require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'full_address' do 
    it 'success' do
      address = Address.new(address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro')

      expect(address.full_address).to eq 'Rua X, 100 - Centro - Manaus/AM'
    end
  end
end
