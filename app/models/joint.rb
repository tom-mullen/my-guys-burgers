class Joint < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :orders, dependent: :destroy

  before_validation :generate_name

  def orders_stream
    [ id, :orders ]
  end

  def kitchen_stream
    [ id, :kitchen_orders ]
  end

  private

  def generate_name
    return true if name.present?

    first_name = %w[ My Shy Fly ].sample
    last_name = %w[ Guys Girls ].sample
    random_number = rand(0..100)

    self.name = "#{first_name} #{last_name} #{random_number}"
    self.slug = nil
  end
end
