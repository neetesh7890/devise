class Album < ApplicationRecord
  #Associations
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy, autosave: true
  has_many :album_images, dependent: :destroy, autosave: true

  #Scopes
  scope :ordered_desc, -> { order(count: :desc) }
  scope :friends_albums, -> (user_ids) { where(user_id: user_ids) }
end
