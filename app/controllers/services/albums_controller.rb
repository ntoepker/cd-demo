class Services::AlbumsController < Services::ApiController
  def create
    @album = Services::Album.new(params[:album])
    @album.save
    respond_with @album
  end

  def index
    @albums = Services::Album.all
    respond_with @albums
  end

  def show
    @album = Services::Album.find(params[:id])
    respond_with @album
  end

  def update
    @album = Services::Album.find(params[:id])
    @album.update_attributes(params[:album])
    respond_with @album
  end

  def destroy
    @album = Services::Album.find(params[:id])
    @album.destroy
    respond_with @album
  end
end
