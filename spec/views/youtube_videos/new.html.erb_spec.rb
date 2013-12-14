require 'spec_helper'

describe "youtube_videos/new" do
  before(:each) do
    assign(:youtube_video, stub_model(YoutubeVideo,
      :youtube_id => "MyString",
      :title => "MyString",
      :description => "MyText",
      :duration => 1,
      :category => "MyString",
      :channel => "MyString"
    ).as_new_record)
  end

  it "renders new youtube_video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", youtube_videos_path, "post" do
      assert_select "input#youtube_video_youtube_id[name=?]", "youtube_video[youtube_id]"
      assert_select "input#youtube_video_title[name=?]", "youtube_video[title]"
      assert_select "textarea#youtube_video_description[name=?]", "youtube_video[description]"
      assert_select "input#youtube_video_duration[name=?]", "youtube_video[duration]"
      assert_select "input#youtube_video_category[name=?]", "youtube_video[category]"
      assert_select "input#youtube_video_channel[name=?]", "youtube_video[channel]"
    end
  end
end
