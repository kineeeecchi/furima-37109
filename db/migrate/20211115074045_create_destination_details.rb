class CreateDestinationDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :destination_details do |t|
      t.string :postal_code,             null: false
      t.integer :shipping_prefecture_id, null: false
      t.string :city,                    null: false
      t.string :address_line1,           null: false
      t.string :address_line2
      t.string :phone_number,            null: false
      t.references :order,               null: false, foreign_key: true

      t.timestamps
    end
  end
end
