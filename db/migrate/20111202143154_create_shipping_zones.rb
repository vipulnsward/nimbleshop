class CreateShippingZones < ActiveRecord::Migration

  def change
    create_table :shipping_zones do |t|
      t.string  :name,          null: false
      t.string  :permalink,     null: false
      t.string  :country_code,  null: false

      t.timestamps
    end
    add_index :shipping_zones, :name,      unique: true
    add_index :shipping_zones, :permalink, unique: true
  end

end
