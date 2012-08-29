class SearchResultsController < ApplicationController
  def show
    @search_results = SearchResults.query(params[:q])
  end
end
