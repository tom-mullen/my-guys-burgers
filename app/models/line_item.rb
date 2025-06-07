class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_price_from_item, on: :create

  private

  def set_price_from_item
    self.price ||= item&.price
  end
end
