class Instrument < ApplicationRecord
  before_destroy :not_refereced_by_any_line_item
  after_validation :normalize_title, on: :create
  belongs_to :user, optional: true
  has_many :line_items
  has_many :carts, through: :line_items
  has_many :ordered_items, dependent: :destroy
  has_many :orders, through: :ordered_items
  has_and_belongs_to_many :wishlists, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  serialize :image, JSON 

  validates :title, :brand, :price, :model,:color, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
  validates :title, length: { maximum: 30, too_long: "%{count} characters is the maximum aloud. "}
  validates :price, length: { maximum: 7 }
  validates :price, numericality: {only_decimal: true, greater_than: 0}
  #validates :quantity, numericality: {only_integer: true, greater_than: 0}

  BRAND = %w{ Fender Gibson Epiphone ESP Martin Dean Taylor Jackson PRS  Ibanez Charvel Washburn }
  COLOR = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

  private

  def not_refereced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end

  def normalize_title
  self.title = title.upcase
  end

end
