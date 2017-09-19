class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include ImageSize

  #Validations
  # validates :email, uniqueness: true, presence: true,format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates_presence_of :firstname, :lastname,:gender,:dob
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

  #Public Class Methods
  def self.search(search)
    search.present? ? where('lower(firstname) LIKE ?', "%#{search.downcase}%") : nil    
  end
end
