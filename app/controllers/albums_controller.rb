class AlbumsController < ApplicationController
  respond_to :html

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    @album.save
    respond_with @album, :location => albums_path
  end

  def index
    @albums = Album.all
    respond_with @albums
  end

  def show
    @album = Album.find(params[:id])
    respond_with @album
  end

  def edit
    @album = Album.find(params[:id])
    respond_with @album
  end

  def update
    @album = Album.find(params[:id])
    @album.update_attributes(params[:album])
    respond_with @album, :location => albums_path
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_path
  end
end
