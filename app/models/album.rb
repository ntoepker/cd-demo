class Album < ApiResource
  self.collection_name = 'albums'

  schema do
    string 'artist', 'title'
  end
end
