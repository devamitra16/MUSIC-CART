class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :instrument
  def total_price
    instrument.price.to_i * quantity.to_i
  end
end
