class AddSlugToJoints < ActiveRecord::Migration[8.0]
  def change
    add_column :joints, :slug, :string
    add_index :joints, :slug, unique: true
  end
end
