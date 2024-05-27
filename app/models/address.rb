class Address < ApplicationRecord
  STATES = ["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MS","MT","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"]
  belongs_to :inn, optional: true
  validates :address, :postal_code, :number, :neighborhood, :city, :state, presence: true, on: :update

  def full_address
    "#{address}, #{number} - #{neighborhood} - #{city}/#{state}"
  end
end