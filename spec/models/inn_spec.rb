require 'rails_helper'

RSpec.describe Inn, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:registration_number) }
    it { should validate_presence_of(:description).on(:update) }
    it { should belong_to(:inn_owner) }
    it { should have_one(:address) }
    it { should have_many(:inn_rooms) }

    it { should accept_nested_attributes_for(:address)}
  end
end
