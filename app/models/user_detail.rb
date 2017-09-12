class UserDetail < ApplicationRecord
  #Validations
  validates_presence_of :address,:city,:pincode
  validates :pincode, numericality: { only_integer: true}
  validates :phone, length: {is: 10},numericality: { only_integer: true}
  # validates :address, presence: true
  # validates :city, presence: true

  #Associations
  belongs_to :user
end
