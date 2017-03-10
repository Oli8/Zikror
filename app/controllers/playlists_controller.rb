class PlaylistsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:add_song]
  before_action :require_login
  before_action :check_owner, only: [:edit, :update]
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
  end

  # GET /playlists/new
  def new
    # @playlist = Playlist.new
    @playlist = current_user.playlists.build
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    # @playlist = Playlist.new(playlist_params)
    @playlist = current_user.playlists.build(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_song
    pl = Playlist.find(params[:playlist_id]).playlist_songs.create(song: Song.find(params[:song_id]))
    unless pl.valid?
      render plain: pl.errors.full_messages.first
    else
      pl.save
      render plain: 'Song has been added to the playlist'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:user_id, :name, :description, :image)
    end

    def playlist_owner?
      Playlist.find(params[:id]).user_id == current_user.id
    end

    def check_owner
      unless playlist_owner?
        flash[:notice] = 'You are not authorized to access this page'
        redirect_to :back
      end
    end
end
