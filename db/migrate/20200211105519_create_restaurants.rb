class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name

      t.timestamps
    end
  end
end


# insert into restaurants (id, name, created_at, updated_at ) values (1, 'PT_FOODOO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
# insert into restaurants (id, name, created_at, updated_at ) values (2, 'PT_KYLYMÄ', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
# insert into restaurants (id, name, created_at, updated_at ) values (3, 'PT_NAPA', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
# insert into restaurants (id, name, created_at, updated_at ) values (4, 'PT_FOOBAR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
# insert into restaurants (id, name, created_at, updated_at ) values (5, 'PT_KASTARI', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

# select * from restaurants;