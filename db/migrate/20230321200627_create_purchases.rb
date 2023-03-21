class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.decimal :value, precision: 8, scale: 2
      t.references :user,     null: false, foreign_key: true
      t.references :product,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
