class CreateSubscription < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.boolean :status, default: true
      t.integer :frequency, default: 1
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
