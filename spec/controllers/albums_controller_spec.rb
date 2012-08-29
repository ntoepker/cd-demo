require 'spec_helper'

describe AlbumsController do

  describe "#new" do
    it "creates a new album" do
      @album = double
      Album.should_receive(:new).and_return(@album)
      get :new
    end

    it "assigns an album" do
      get :new
      assigns(:album).should be_instance_of Album
    end

    it "renders the new template" do
      get :new
      response.should render_template("new")
    end
  end

  describe "#create" do
    before(:each) do
      @attr = { "title" => "Title", "artist" => "Artist" }
      @album = mock_model("Album", @attr).as_null_object
      Album.stub(:new).and_return(@album)
    end

    it "builds an album" do
      Album.should_receive(:new).with(@attr).and_return(@album)
      post :create, :album => @attr
    end

    it "tries to save the album" do
      @album.should_receive(:save).and_return(true)
      post :create, :album => @attr
    end

    context "with valid album data" do
      before(:each) do
        @album.stub(:save).and_return(true)
      end

      it "redirects to all albums" do
        post :create, :album => @attr
        response.should redirect_to(albums_path)
      end
    end

    context "with invalid album data" do
      before(:each) do
        @album.stub(:save).and_return(false)
      end

      it "fetches error messages" do
        @album.should_receive(:errors)
        post :create, :album => @attr
      end

      it "renders the new template" do
        @album.stub(:errors).and_return( { :full_messages => ["error message"]} )
        post :create, :album => @attr
        response.should render_template("new")
      end
    end
  end

  describe "#index" do
    it "returns successfully" do
      Album.stub(:all => [])
      get :index
      response.should be_success
    end

    it "fetches all existing albums" do
      Album.should_receive(:all)
      get :index
    end

    it "assigns all albums" do
      Album.stub(:all).and_return("all albums")
      get :index
      assigns(:albums).should == ("all albums")
    end

    it "renders the index template" do
      Album.stub(:all => [])
      get :index
      response.should render_template("index")
    end
  end

  describe "#show" do
    before(:each) do
      @album = mock_model(Album).as_null_object
      Album.stub(:find => @album)
    end

    it "returns successfully" do
      get :show, :id => 1
      response.should be_success
    end

    it "fetches the requested album" do
      Album.should_receive(:find).with("1").and_return(@album)
      get :show, :id => 1
    end

    it "assigns the requested album" do
      get :show, :id => 1
      assigns(:album).should == @album
    end

    it "renders the show template" do
      get :show, :id => 1
      response.should render_template("show")
    end
  end

  describe "#edit" do
    before(:each) do
      @album = mock_model(Album).as_null_object
      Album.stub(:find => @album)
    end

    it "returns successfully" do
      get :edit, :id => 1
      response.should be_success
    end

    it "fetches the requested album" do
      Album.should_receive(:find).with("1").and_return(@album)
      get :edit, :id => 1
    end

    it "assigns the requested album" do
      get :edit, :id => 1
      assigns(:album).should == @album
    end

    it "renders the edit template" do
      get :edit, :id => 1
      response.should render_template("edit")
    end
  end

  describe "#update" do
    before(:each) do
      @attr = { "id" => "1", "title" => "Title", "artist" => "Artist" }
      @album = mock_model("Album", @attr).as_null_object
      Album.stub(:find).and_return(@album)
    end

    it "finds the album" do
      Album.should_receive(:find).with("1").and_return(@album)
      put :update, :id => 1, :album => @attr
    end

    it "tries to update the album" do
      @album.should_receive(:update_attributes).with(@attr).and_return(true)
      put :update, :id => 1, :album => @attr
    end

    context "with valid album data" do
      before(:each) do
        @album.stub(:save).and_return(true)
      end

      it "redirects to all albums" do
        put :update, :id => 1, :album => @attr
        response.should redirect_to(albums_path)
      end
    end

    context "with invalid album data" do
      before(:each) do
        @album.stub(:save).and_return(false)
      end

      it "fetches error messages" do
        @album.should_receive(:errors)
        put :update, :id => 1, :album => @attr
      end

      it "renders the edit template" do
        @album.stub(:errors).and_return( { :full_messages => ["error message"]} )
        put :update, :id => 1, :album => @attr
        response.should render_template("edit")
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      @album = mock_model(Album).as_null_object
      Album.stub(:find => @album)
    end

    it "fetches the requested album" do
      Album.should_receive(:find).with("1").and_return(@album)
      delete :destroy, :id => 1
    end

    it "destroys the album" do
      @album.should_receive(:destroy)
      delete :destroy, :id => 1
    end

    it "redirects to all albums" do
      delete :destroy, :id => 1
      response.should redirect_to(albums_path)
    end
  end

end
