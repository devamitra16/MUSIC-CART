class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :instruments
  has_many :orders
  has_many :payments
  has_one :cart
  has_one :wishlist

  validates_presence_of :password, :email
  
  belongs_to:accountable,polymorphic:true, inverse_of: :user

  scope :customer, -> { where(accountable_type: "Customer") }
  scope :seller, -> { where(accountable_type: "Seller") }

 

  


  ACCOUNTABLETYPE = %w{ seller customer }

   def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
