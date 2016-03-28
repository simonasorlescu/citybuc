class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :location_id
      t.integer :category_id
      t.datetime :subscribed_off

      t.timestamps
    end
  end
end
