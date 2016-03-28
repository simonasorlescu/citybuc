class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :description
      t.integer :rating
      t.integer :user_id
      t.integer :location_id
      t.integer :event_id

      t.timestamps
    end
  end
end
