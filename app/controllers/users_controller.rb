class UsersController < ApplicationController
  before_action :require_login, except: [:create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :is_owner, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    unless params[:username].nil?
      @users =  User.where("username LIKE ?", "%#{params[:username]}%")
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @artists = @user.songs.group(:artist).count.sort.reverse
    unless params[:username].nil?
      @users_list =  User.where("username LIKE ?", "%#{params[:username]}%")
    else
      @users_list = User.all()
    end
  end

  # GET /users/1/edit
  def edit
  end

  def favorite
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { redirect_to @user, notice: "Votre inscription s'est bien éffectué. Bienvenue sur Zikror !" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render 'session/new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Votre compte a été modifié avec succès !' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'L\'utilisateur a été supprmé avec succès' }
      format.json { head :no_content }
    end
  end

  def follow
    user = User.find(params[:id])
    unless current_user.follow?(user)
      current_user.follow(user)
      render plain: "#{current_user.username} is now following #{user.username}"
    else
      current_user.unfollow(user)
      render plain: "#{current_user.username} is not following #{user.username} anymore"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:id].to_i != 0
        @user = User.find(params[:id])
      else
        @user = User.find_by(username: params[:id])
      end

      render404 if @user.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :mail, :description, :password, :password_confirmation)
    end

end
