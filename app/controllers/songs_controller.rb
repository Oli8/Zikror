class SongsController < ApplicationController
  before_action :require_login
  before_action :check_access, only: [:show]
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update]
  # GET /songs
  # GET /songs.json
  def index
    genre = params[:genre] == 'Genre' ? '' : params[:genre]
    @songs = Song.where("(title LIKE ? OR artist LIKE ?) AND genre LIKE ? AND private = ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{genre}%", false).paginate(page: params[:page], per_page: ITEMS_PER_PAGE)
    flash.now[:notice] = "Nothing found" if @songs.empty?
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = current_user.songs.build
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = current_user.songs.build(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'La musique a bien été supprimée.' }
      format.json { head :no_content }
    end
  end

  def favorite
    song = Song.find(params[:song_id])
    msg = ''
    if song.private && song.user != current_user
      msg = 'Vous ne pouvez pas ajouter une chanson privée à vos favoris'
    elsif !song.nil?
      f = current_user.favorite_songs.create(song: song)
      if f.valid?
        msg = "#{song.title} a été ajoutée à vos favoris"
      else
        FavoriteSong.find_by(user_id: current_user.id, song_id: song.id).destroy
        msg = "#{song.title} a été retiré de vos favoris"
      end
    end
    render plain: msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:user_id, :title, :artist, :year, :genre, :private, :file)
    end

    def check_owner
      unless song_owner?
        flash[:notice] = 'You are not authorized to access this page'
        redirect_to :back
      end
    end

    def song_owner?
      Song.find(params[:id]).user_id == current_user.id
    end

    def check_access
      if Song.find(params[:id]).private && !song_owner?
        flash[:notice] = 'You are not authorized to access this page'
        redirect_to songs_path
      end
    end

end
