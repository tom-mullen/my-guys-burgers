class AddJointToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :joint, null: false, foreign_key: true
  end
end
