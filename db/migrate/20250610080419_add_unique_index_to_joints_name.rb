class AddUniqueIndexToJointsName < ActiveRecord::Migration[8.0]
  def change
    add_index :joints, :name, unique: true
  end
end
