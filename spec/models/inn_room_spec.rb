require 'rails_helper'

RSpec.describe InnRoom, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:size) }
  it { should validate_numericality_of(:guest_limit) }
  it { should belong_to(:inn) }
  it { should have_one_attached(:photo) }
end
