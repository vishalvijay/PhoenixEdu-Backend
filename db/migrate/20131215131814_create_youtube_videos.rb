class CreateYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos do |t|
      t.string :yid, comment: "Youtube video id", null: false
      t.string :title, comment: "Video title", null: false
      t.text :description, comment: "Video description"
      t.integer :duration, comment: "Video duration", default:0, null: false
      t.string :category, comment: "Category", default: "Unkonwn", null: false
      t.string :channel, comment: "Channel", default: "Unkonwn", null: false

      t.timestamps
    end
    add_index :youtube_videos, :yid, unique: true
  end
end