class DeletedYoutubeVideosController < InheritedResources::Base
	respond_to :json
	respond_to :html,:xml, :except => [:index]
	actions :index

	protected

	def collection
		@deleted_youtube_videos = based_on_time(@deleted_youtube_videos) || based_on_time(end_of_association_chain.all)
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