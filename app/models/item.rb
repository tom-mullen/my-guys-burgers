class Item < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items

  enum :category, {
    main: "main",
    topping: "topping",
    side: "side",
    drink: "drink",
    general: "general"
  }

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true

  scope :by_category, -> {
    order(
      Arel.sql(
        "CASE category
         WHEN 'main' THEN 1
         WHEN 'topping' THEN 2
         WHEN 'side' THEN 3
         WHEN 'drink' THEN 4
         ELSE 5
         END"
      )
    )
  }

  def surcharge
    formatted_price if [ "Bacon", "Cheese", "Chocolate Shake", "Vanilla Shake" ].include?(name)
  end

  def formatted_price
    "£#{'%.2g' % price}"
  end
end
