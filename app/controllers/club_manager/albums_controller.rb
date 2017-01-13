class ClubManager::AlbumsController < BaseClubManagerController
  before_action :load_album, except: [:index, :create]
  before_action :correct_manager

  def index
    @club = Club.find_by id: params[:club_id]
    unless @club
      flash[:danger] = t "cant_found_club"
      redirect_to club_manager_path
    end
    @albums = @club.albums.newest.page(params[:page]).per Settings.per_page_album
    @album = Album.new
  end

  def show
    @images = @album.images.page(params[:page]).per Settings.per_page_image
    @image = Image.new
    @club = Club.find_by id: @album.club_id
  end

  def create
    album = Album.new album_params
    if album.save
      flash[:success] = t "club_manager.album.success_create"
      redirect_to club_manager_club_albums_path params[:club_id]
    else
      flash_error album
      redirect_to club_manager_club_albums_path params[:club_id]
    end
  end

  def edit

  end

  def update
    if @album.update_attributes album_params
      create_acivity @album, current_user, Settings.update
      flash[:success] = t "club_manager.album.success_update"
    else
      flash_error @album
    end
    redirect_to :back
  end
  private
  def load_album
    @album = Album.find_by id: params[:id]
    unless @album
      flash[:danger] = t "club_manager.album.not_found"
      redirect_to club_manager_club_albums_path params[:club_id]
    end
  end

  def album_params
    params.require(:album).permit :club_id, :name
  end
end
