require 'rails_helper'

RSpec.describe InnOwner, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:document) }
  it { should validate_uniqueness_of(:document) }

  it { should accept_nested_attributes_for(:inn)}
end
