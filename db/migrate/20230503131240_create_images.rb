class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.integer :article_id, null: false
      t.string :image_id, null: false

      t.timestamps
    end
  end
end
