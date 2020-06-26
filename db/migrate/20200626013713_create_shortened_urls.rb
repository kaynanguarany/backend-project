class CreateShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_urls do |t|
      t.string :url, null: false
      t.string :code, null: false
      t.integer :access_count, null: false, default: 0

      t.timestamps
    end
  end
end
