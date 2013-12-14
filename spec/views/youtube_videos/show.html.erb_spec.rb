require 'spec_helper'

describe "youtube_videos/show" do
  before(:each) do
    @youtube_video = assign(:youtube_video, stub_model(YoutubeVideo,
      :youtube_id => "Youtube",
      :title => "Title",
      :description => "MyText",
      :duration => 1,
      :category => "Category",
      :channel => "Channel"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Youtube/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Channel/)
  end
end
