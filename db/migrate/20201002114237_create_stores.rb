class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :models_count
      t.timestamps
    end

    add_index :stores, :name, unique: :true
  end
end
