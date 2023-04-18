class Wishlist < ApplicationRecord
	belongs_to :user
	has_and_belongs_to_many :instruments, dependent: :destroy
end

