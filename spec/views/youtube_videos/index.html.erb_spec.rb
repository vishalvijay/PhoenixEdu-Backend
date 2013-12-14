require 'spec_helper'

describe "youtube_videos/index" do
  before(:each) do
    assign(:youtube_videos, [
      stub_model(YoutubeVideo,
        :youtube_id => "Youtube",
        :title => "Title",
        :description => "MyText",
        :duration => 1,
        :category => "Category",
        :channel => "Channel"
      ),
      stub_model(YoutubeVideo,
        :youtube_id => "Youtube",
        :title => "Title",
        :description => "MyText",
        :duration => 1,
        :category => "Category",
        :channel => "Channel"
      )
    ])
  end

  it "renders a list of youtube_videos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Youtube".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Channel".to_s, :count => 2
  end
end
