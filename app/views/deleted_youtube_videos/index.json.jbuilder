json.array!(@deleted_youtube_videos) do |deleted_youtube_video|
  json.extract! deleted_youtube_video, :yid
end
