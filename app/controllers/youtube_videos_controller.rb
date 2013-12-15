class YoutubeVideosController < InheritedResources::Base
	respond_to :json
	respond_to :html, :except => [:index, :show]
	actions :index, :show

	protected

	def collection
		@youtube_videos = based_on_time(@youtube_videos) || based_on_time(end_of_association_chain.all).page(params[:page])
	end

	private

	def based_on_time(input)
		if params[:time].present? and !input.nil?
			input.where("updated_at > ?", params[:time]) 
		else
			input
		end
	end
end