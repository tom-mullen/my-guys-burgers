class Joint < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :orders

  def orders_stream
    [ id, :orders ]
  end

  def kitchen_stream
    [ id, :kitchen_orders ]
  end
end
