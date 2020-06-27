class CreateShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_urls do |t|
      t.string :url
      t.string :destination_url, null: false
      t.integer :access_count, null: false, default: 0

      t.timestamps
    end
  end
end
