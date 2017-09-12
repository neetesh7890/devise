class UserFriend < ApplicationRecord
  
  #Associations
  belongs_to :user, inverse_of: :user_friends
  belongs_to :friend, class_name: "User" #friend ka association user se
  
  scope :entries_to_be_removed, -> (by_token) { where(token: by_token) }

  def self.accepted?(token)
    self.find_by(token: token).status == "accept" ? true : false
  end
end
