require 'spec_helper'

describe Services::AlbumsController do

  describe "#create" do
    before(:each) do
      @attr = { "title" => "Title", "artist" => "Artist" }
    end

    it "builds an album" do
      album = mock_model("Album").as_null_object
      Services::Album.should_receive(:new).with(@attr).and_return(album)
      post :create, :album => @attr, :format => :json
    end

    it "tries to save the album" do
      album = double.as_null_object
      Services::Album.stub(:new).and_return(album)
      album.should_receive(:save).and_return(true)
      post :create, :album => @attr
    end

    context "with valid album data" do
      it "responds with code 'created' (201)" do
        post :create, "album" => @attr, :format => :json
        response.code.should == "201"
      end

      it "returns the album" do
        album = stub_model(Services::Album, :save => true)
        Services::Album.stub(:new).and_return(album)
        post :create, :format => :json
        response.body.should == album.to_json
      end
    end

    context "with invalid album data" do
      before(:each) do
        @album = mock_model("Album", @attr).as_null_object
        Services::Album.stub(:new).and_return(@album)
        @album.stub(:save => false, :errors => "error message")
      end

      it "responds with code 'unprocessable entity' (422)" do
        post :create, "album" => @attr, :format => :json
        response.code.should == "422"
      end

      it "returns error message" do
        post :create, :album => @attr, :format => :json
        response.body.should match(/error message/)
      end
    end
  end

  describe "#index" do
    it "returns successfully" do
      get :index, :format => :json
      response.should be_success
    end

    it "fetches all existing albums" do
      Services::Album.should_receive(:all)
      get :index, :format => :json
    end

    it "returns all existing albums" do
      Services::Album.stub_chain(:all, :to_json).and_return("all albums")
      get :index, :format => :json
      response.body.should == "all albums"
    end
  end

  describe "#show" do
    before(:each) do
      @album = mock_model("Album").as_null_object
      Services::Album.stub(:find => @album)
    end

    it "returns successfully" do
      get :show, :id => 1, :format => :json
      response.should be_success
    end

    it "fetches the requested album" do
      Services::Album.should_receive(:find).with("1").and_return(@album)
      get :show, :id => 1, :format => :json
    end

    it "returns the requested album" do
      Services::Album.stub_chain(:find, :to_json).and_return("this album")
      get :show, :id => 1, :format => :json
      response.body.should == "this album"
    end
  end

  describe "#update" do
    before(:each) do
      @attr = { "id" => "1", "title" => "Title", "artist" => "Artist" }
      @album = mock_model("Album", @attr).as_null_object
      Services::Album.stub(:find).and_return(@album)
    end

    it "finds the album" do
      Services::Album.should_receive(:find).with("1").and_return(@album)
      put :update, :id => 1, :album => @attr, :format => :json
    end

    it "tries to update the album" do
      @album.should_receive(:update_attributes).with(@attr).and_return(true)
      put :update, :id => 1, :album => @attr, :format => :json
    end

    context "with valid album data" do
      before(:each) do
        @album.stub(:update_attributes).and_return(true)
      end

      it "returns blank" do
        put :update, :id => 1, :album => @attr, :format => :json
        response.body.should be_blank
      end
    end

    context "with invalid album data" do
      before(:each) do
        @album.stub(:save).and_return(false)
      end

      it "fetches error messages" do
        @album.should_receive(:errors)
        put :update, :id => 1, :album => @attr, :format => :json
      end

      it "returns error message" do
        @album.stub(:errors).and_return( { :full_messages => ["error message"]} )
        put :update, :id => 1, :album => @attr, :format => :json
        response.body.should match(/error message/)
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      @album = mock_model("Album").as_null_object
      Services::Album.stub(:find => @album)
    end

    it "fetches the requested album" do
      Services::Album.should_receive(:find).with("1").and_return(@album)
      delete :destroy, :id => 1
    end

    it "destroys the album" do
      @album.should_receive(:destroy)
      delete :destroy, :id => 1
    end

    it "returns blank" do
      delete :destroy, :id => 1
      response.body.should be_blank
    end
  end

end
