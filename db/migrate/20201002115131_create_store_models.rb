class CreateStoreModels < ActiveRecord::Migration[6.0]
  def change
    create_table :store_models do |t|
      t.references :store
      t.string :name
      t.integer :inventory

      t.timestamps
    end

    add_index :store_models, [:store_id, :name], unique: :true
  end
end
