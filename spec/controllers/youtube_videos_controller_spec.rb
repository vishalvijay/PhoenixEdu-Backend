require 'spec_helper'

describe YoutubeVideosController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', :format => :json
      expect(response).to be_success
    end
  end

  # describe "GET 'show'" do
  #   it "returns http success" do
  #     get 'show', :format => :json
  #     expect(response).to be_success
  #   end
  # end

end
