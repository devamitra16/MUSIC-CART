class Order < ApplicationRecord
    after_create :destroy_line_items_from_cart 
    #before_create :check_cart_has_line_items
	has_many :ordered_items
	has_many:instruments, through: :ordered_items
    has_one :payment
    accepts_nested_attributes_for :payment
	belongs_to :user
	belongs_to :cart

	validates :address, :contact_number, presence: true
	validates :address, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
	validates :contact_number, numericality: {only_integer: true}
	validates :contact_number,length: {minimum: 10, maximum: 10}
    
	def total_price
    ordered_items.to_a.sum { |item| item.total_price }
  end

  private
  def destroy_line_items_from_cart
    cart.line_items.destroy_all
  end

  def check_cart_has_line_items
     if cart.line_items.count <= 0
     	errors.add(:base, "You dont have any items in your cart")
      throw :abort
  end
end


   
end
	