require 'spec_helper'

describe "YoutubeVideos" do
  describe "GET /youtube_videos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get youtube_videos_path
      expect(response.status).to be(200)
    end
  end
end
