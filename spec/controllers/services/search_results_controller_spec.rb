require 'spec_helper'

describe Services::SearchResultsController do
  describe "#show" do
    before(:each) do
      @album = mock_model("Album").as_null_object
      Services::Album.stub(:find => [@album])
    end

    it "returns successfully" do
      get :show, :format => :json
      response.should be_success
    end

    it "fetches the requested album" do
      q = "u_name_it"
      Services::Album.should_receive(:where).with("artist LIKE ? OR title LIKE ?", "%#{q}%", "%#{q}%").and_return([@album])
      get :show, :q => q, :format => :json
    end

    it "returns the requested album" do
      Services::Album.stub_chain(:where, :to_json).and_return("this album")
      get :show, :q => "u_name_it", :format => :json
      response.body.should == "this album"
    end
  end
end
