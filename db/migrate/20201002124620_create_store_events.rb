class CreateStoreEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :store_events do |t|
      t.references :store, :store_model
      t.integer :inventory

      t.timestamps
    end

    add_index :store_events, :created_at
  end
end
