class Joint < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :orders, dependent: :destroy

  validates :name, presence: { message: "You need to give the place a name." }, uniqueness: { message: "That name is already being used." }

  def orders_stream
    [ id, :orders ]
  end

  def kitchen_stream
    [ id, :kitchen_orders ]
  end
end
