class YoutubeVideo < ActiveRecord::Base
	validates :youtube_id, :title, :description, presence: true
	validates :youtube_id, uniqueness: true
	validates :duration, numericality: true
end
