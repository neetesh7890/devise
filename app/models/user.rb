class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter]

  include ImageSize

  #Validations
  # validates :email, uniqueness: true, presence: true,format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  # validates_presence_of :name, :lastname  #,:gender,:dob
  validate :avatar_size , if: :avatar?

  #Attributes
  attr_accessor :size, :avatar
  
  #Associations
  has_one :user_detail, dependent: :destroy, :autosave => true
  has_many :albums, dependent: :destroy
  has_many :user_friends, dependent: :destroy, inverse_of: :user
  has_many :friends, through: :user_friends

  accepts_nested_attributes_for :user_detail

  #Scopes
  scope :confirm_friend, ->{ where("user_friends.status ='accept'") }
  scope :pending_friend, ->{ where("user_friends.status ='pending'") }# how to merge these two lines into one
  scope :all_friends, -> (ids) { where.not(id: ids) }
  
  #Uploader
  mount_uploader :avatar, AvatarUploader

  after_initialize do |user|
    AwesomeGem::WhoIs.awesome?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(name: data['name'],lastname: data['last_name'],email: data['email'],password: Devise.friendly_token[0,20])
    end
    user
  end

  def self.find_or_create_from_auth_hash(autohash) #Twitter
    user = User.where(username: autohash[:info][:nickname]).first
    unless user
      user = User.create(name: autohash[:info][:name], username: autohash[:info][:nickname], password: Devise.friendly_token[0,20], email: autohash[:credentials][:token]+"@"+autohash[:provider]+".com")
    end
    user
  end

  def self.find_for_facebook_oauth(auth)
    debugger
    user = User.where(email: auth[:info][:email]).first
    unless user
      user = User.create(name: auth[:info][:name], email: auth[:info][:email], password: Devise.friendly_token[0,20], provider: auth[:provider])
    end
    user
  end
  

  # def self.from_omniauth(auth)
  #   debugger
  #   where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.firstname = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end

  #Public Class Methods
  def self.search(search)
    search.present? ? where('lower(name) LIKE ?', "%#{search.downcase}%") : nil    
  end
end
