class Order < ApplicationRecord
  attr_accessor :items_main, :items_topping_ids, :items_side, :items_drink

  belongs_to :joint
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items

  validates :customer_name, presence: { message: "Your name can't be blank!" }
  validates :items_main, presence: { message: "You must choose at least 1 main." }
  validates :items_side, presence: { message: "You must choose at least 1 side." }

  accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank

  after_commit :broadcast_refresh

  private

  def broadcast_refresh
    broadcast_refresh_to joint.kitchen_stream
    broadcast_refresh_to joint.orders_stream
  end
end
