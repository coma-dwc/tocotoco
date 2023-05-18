class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true, index: true
      t.references :article, foreign_key: true, index: true

      t.timestamps
      t.index [:user_id, :article_id], unique: true
    end
  end
end
