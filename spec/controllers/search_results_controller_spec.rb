require 'spec_helper'

describe SearchResultsController do
  describe "#show" do
    it "returns successfully" do
      get :show
      response.should be_success
    end

    context "without given search parameters" do
      it "assigns empty search_results" do
        SearchResults.stub(:query).and_return([])
        get :show
        assigns(:search_results).should == []
      end
    end

    context "with given search parameters" do
      it "starts a search query" do
        SearchResults.should_receive(:query).with("looking for something")
        get :show, :q => "looking for something"
      end

      it "returns the search results" do
        SearchResults.stub(:query).and_return("here are the results")
        get :show, :q => "looking for something"
        assigns(:search_results).should == "here are the results"
      end
    end
  end
end
