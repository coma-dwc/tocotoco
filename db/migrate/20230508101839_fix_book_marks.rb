class FixBookMarks < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmarks, :user_id, :integer, null: false, foreign_key: true
    add_column :bookmarks, :article_id, :integer, null: false, foreign_key: true

    remove_column :bookmarks, :user
    remove_column :bookmarks, :article
  end
end
