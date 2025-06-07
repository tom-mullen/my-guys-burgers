class Order < ApplicationRecord
  attr_accessor :items_main, :items_topping_ids, :items_side, :items_drink

  has_many :line_items
  has_many :items, through: :line_items

  validates :customer_name, presence: { message: "Your name can't be blank!" }
  validates :items_main, presence: { message: "You must choose at least 1 main." }
  validates :items_side, presence: { message: "You must choose at least 1 side." }

  accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank

  after_create_commit :broadcast_to_kitchen

  private

  def broadcast_to_kitchen
    ActionCable.server.broadcast(
      "kitchen",
      {
        order_html: ApplicationController.render(
          partial: "orders/order",
          locals: { order: self }
        )
      }
    )
  end
end
