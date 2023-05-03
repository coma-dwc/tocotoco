class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :prefectures, null: false

      t.timestamps
    end
  end
end
