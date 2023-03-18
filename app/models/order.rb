class Order < ApplicationRecord
	belongs_to :instrument
	belongs_to :line_item
	has_many :line_items
	belongs_to :cart
end
