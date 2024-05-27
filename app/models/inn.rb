class Inn < ApplicationRecord
  validates :name, :registration_number, presence: true, on: :create
  validates :name, :registration_number, :description, presence: true, on: :update
  validates :registration_number, uniqueness: true

  belongs_to :inn_owner
  has_one :address
  has_many :inn_rooms
  accepts_nested_attributes_for :address
  delegate :full_address, to: :address

  scope :active, -> { where(active: true)}
end
