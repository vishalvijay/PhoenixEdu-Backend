class YoutubeVideosController < InheritedResources::Base
	require 'net/http'

	def create
    @youtube_video = YoutubeVideo.new
    response = nil
    respond_to do |format|
    	begin
    		if params[:youtube_video][:youtube_id].present?
					youtube_id = params[:youtube_video][:youtube_id]
					url = URI.parse("http://gdata.youtube.com/feeds/api/videos/#{youtube_id}?v=2&alt=json")
					req = Net::HTTP::Get.new(url.path)
					response = Net::HTTP.start(url.host, url.port) {|http|http.request(req)} 
					entry = Hash.from_xml(response.body)['entry']
					group = entry['group']
					@youtube_video.youtube_id = youtube_id
					@youtube_video.title = entry['title']
					@youtube_video.description = group['description']
					begin
						@youtube_video.duration = (group['content'][0])['duration']
					rescue
						@youtube_video.duration = (group['content'])['duration']
					end
					@youtube_video.category = group['category']
					@youtube_video.channel = entry['author']['name']
				end		
	      if @youtube_video.save
	        format.html { redirect_to @youtube_video, notice: 'Youtube video was successfully created.' }
	        format.json { render json: @youtube_video, status: :created, location: @youtube_video }
	      else
	      	@youtube_video.errors.delete(:title) 
	        @youtube_video.errors.delete(:description)
	        format.html { render action: "new" }
	        format.json { render json: @youtube_video.errors, status: :unprocessable_entity }
	      end
		  rescue Exception => e
		  	error_message = "Unable to create Youtube video. Please validate video id and try again"
		  	code=500
		  	unless response.nil?
		  		code = response.code || 500
        end
        format.html { render action: "index", notice: error_message, status: code }
        format.json { render json: { :error_message => error_message }, status: code }
		  end
    end	
	end

	def destroy
		@youtube_video = YoutubeVideo.find(params[:id])
		DeletedYoutubeVideo.create({youtube_id: @youtube_video.youtube_id})
		@youtube_video.destroy

    respond_to do |format|
      format.html { redirect_to youtube_videos_url }
      format.json { head :no_content }
    end
  end

	def permitted_params
		params.permit(:youtube_video => [:youtube_id])
	end
end