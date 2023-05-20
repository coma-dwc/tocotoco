class CreateArticleHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :article_hashtags do |t|
      t.references :article, index: true
      t.references :hashtag, index: true

      t.timestamps
      t.index [:article_id, :hashtag_id], unique: true
    end
  end
end
