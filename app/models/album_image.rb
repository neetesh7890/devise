class AlbumImage < ApplicationRecord
   #Association
  belongs_to :album

  #Validations
  validate :avatar_size , if: :image_name?

  #Uploader
  mount_uploader :image_name, AvatarUploader

  attr_accessor :size
  def avatar_size
    errors.add(:base, "Image should be less than 5MB") if size > 5.megabytes
  end 
end
