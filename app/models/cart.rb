class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :instruments, through: :line_items
  has_many :orders
  belongs_to :user
  def add_instrument(instrument)
    current_item = line_items.find_by(instrument_id: instrument.id)
    if current_item
      current_item.increment(:quantity)
    else
      current_item = line_items.build(instrument_id: instrument.id, cart_id: id)

    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end


  
end