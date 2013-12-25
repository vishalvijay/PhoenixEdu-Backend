ActiveAdmin.register YoutubeVideo do
  menu priority: 0
  permit_params :yid

  form do |f|
    f.inputs do
      f.input :yid
      if !f.object.new_record?
        f.input :title 
        f.input :description
        f.input :duration
        f.input :category
        f.input :channel
      end
    end
    f.actions
  end

  batch_action :destroy do |selection|
    selection.each do |id|
      @youtube_video = YoutubeVideo.find(id)
      DeletedYoutubeVideo.create({yid: @youtube_video.yid})
      @youtube_video.destroy
    end
    redirect_to collection_path, :notice => "Deleted"
  end

  controller do
    require 'net/http'
    
    def create
      @youtube_video = YoutubeVideo.new
      response = nil
      respond_to do |format|
        begin
          if params[:youtube_video][:yid].present?
            yid = params[:youtube_video][:yid]
            url = URI.parse("http://gdata.youtube.com/feeds/api/videos/#{yid}?v=2&alt=json")
            req = Net::HTTP::Get.new(url.path)
            response = Net::HTTP.start(url.host, url.port) {|http|http.request(req)} 
            entry = Hash.from_xml(response.body)['entry']
            group = entry['group']
            @youtube_video.yid = yid
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
            format.html { render 'index', notice: 'Youtube video was successfully created.' }
            format.json { render json: @youtube_video, status: :created, location: @youtube_video }
          else
            delete_unwanted_errors
            format.html { render action: "new" }
            format.json { render json: @youtube_video.errors, status: :unprocessable_entity }
          end
        rescue Exception => e
          delete_unwanted_errors
          @youtube_video.errors.set(:yid, ["Unable to create Youtube video. Please validate video id and try again"])
          code=:bad_request
          unless response.nil?
            code = response.code || code
          end
          format.html { redirect_to admin_youtube_videos_url }
          format.json { render json: @youtube_video.errors, status: code }
        end
      end 
    end  
    
    def destroy
      @youtube_video = YoutubeVideo.find(params[:id])
      DeletedYoutubeVideo.create({yid: @youtube_video.yid})
      @youtube_video.destroy

      respond_to do |format|
        format.html { redirect_to admin_youtube_videos_url }
        format.json { head :no_content }
      end
    end

    private
    
    def delete_unwanted_errors
      @youtube_video.errors.delete(:title) 
    end
  end
end