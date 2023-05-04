class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user, foreign_key: true
      t.integer :article, foreign_key: true

      t.timestamps
    end

    add_index :bookmarks, [:user_id, :article_id], unique: true
  end
end
