class CreateDeletedYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :deleted_youtube_videos do |t|
      t.string :youtube_id

      t.timestamps
    end
  end
end
