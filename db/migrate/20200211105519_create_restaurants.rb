class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name

      t.timestamps
    end
  end
end

# PT_FOODOO
# PT_KYLYMÄ
# PT_NAPA
# PT_FOOBAR
# PT_KASTARI