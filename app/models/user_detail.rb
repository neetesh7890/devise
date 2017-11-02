class UserDetail < ApplicationRecord
  
  #Validations
  validates_presence_of :address,:city,:pincode
  validates :pincode, numericality: { only_integer: true}
  validates :phone, length: {is: 10},numericality: { only_integer: true}

  #Associations
  belongs_to :user
end
