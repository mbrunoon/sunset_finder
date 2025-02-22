class CreateSunsets < ActiveRecord::Migration[8.0]
  def change
    create_table :sunsets do |t|
      t.string :location
      t.date :occurs_at
      t.json :data

      t.timestamps
    end
  end
end
