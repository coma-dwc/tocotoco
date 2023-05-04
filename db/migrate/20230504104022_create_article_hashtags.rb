class CreateArticleHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :article_hashtags, id: false do |t|
      t.references :article_id, index: true, foreign_key: true
      t.references :hashtag_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
