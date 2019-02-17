class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.datetime :publish_at
      t.string :image_url
      t.text :description

      t.timestamps
    end
  end
end
