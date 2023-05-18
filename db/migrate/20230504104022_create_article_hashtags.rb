class CreateArticleHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :article_hashtags, id: false do |t|
      t.references :article, index: true, foreign_key: true
      t.references :hashtag, index: true, foreign_key: true

      t.timestamps
      t.index [:article_id, :hashtag_id], unique: true
    end
  end
end
