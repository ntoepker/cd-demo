class SearchResults < ApiResource
  self.collection_name = 'search_results'

  def self.query(search_string)
    if search_string.blank?
      []
    else
      find(:all, :params => { :q => search_string })
    end
  end
end
