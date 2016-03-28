class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :url
      t.datetime :date
      t.integer :location_id
      t.string :picture

      t.timestamps
    end
  end
end
