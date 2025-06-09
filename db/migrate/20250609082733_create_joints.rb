class CreateJoints < ActiveRecord::Migration[8.0]
  def change
    create_table :joints do |t|
      t.string :name

      t.timestamps
    end
  end
end
