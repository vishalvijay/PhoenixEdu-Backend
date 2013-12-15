class YoutubeVideo < ActiveRecord::Base
	validates :yid, :title, presence: true
	validates :yid, uniqueness: true
	validates :duration, numericality: true
end