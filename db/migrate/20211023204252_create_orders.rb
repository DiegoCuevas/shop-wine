class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :mount
      t.references :user, null: false, foreign_key: true
      t.string :payment_status
      t.string :order_status
      t.date :payment_date
      t.date :delivery_date

      t.timestamps
    end
  end
end
