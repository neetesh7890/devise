class Album < ApplicationRecord
  #Associations
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy, autosave: true
  has_many :album_images, dependent: :destroy, autosave: true
  # validates :image_name, presence: true
  
  #Scopes
  scope :albums_order_by_comments, -> { order('comment_count DESC') }

  #Uploader
  # mount_uploader :image_name, AvatarUploader
end
