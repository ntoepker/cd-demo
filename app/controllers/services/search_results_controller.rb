class Services::SearchResultsController < Services::ApiController
  def show
    q = "%#{params[:q]}%"
    @search_results = Services::Album.where("artist LIKE ? OR title LIKE ?", q, q)
    respond_with @search_results
  end
end
