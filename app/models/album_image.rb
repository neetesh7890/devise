class AlbumImage < ApplicationRecord
  
  include ImageSize

   #Association
  belongs_to :album

  #Validations
  validate :avatar_size , if: :image_name?

  #Uploader
  mount_uploader :image_name, AvatarUploader

  attr_accessor :size
end
