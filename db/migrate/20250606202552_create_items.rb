class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.integer :order_id
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
