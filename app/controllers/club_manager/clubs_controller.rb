class ClubManager::ClubsController < BaseClubManagerController

  before_action :load_club
  before_action :manager_club

  def show
    @event = Event.new
  end

  def update
    if @club.update_attributes club_params
      create_acivity @club, current_user, Settings.update
      flash[:success] = t "club_manager.club.success_update"
    else
      flash_error @club
    end
    redirect_to :back
  end

  private
  def club_params
    params.require(:club).permit :name, :description, :logo,
      :notification
  end

  def load_club
    @club = Club.find_by id: params[:id]
    unless @club
      flash[:danger] = t "club_manager.cant_fount"
      redirect_to club_manager_path
    end
  end

  def manager_club
    correct_manager = manager_of_club(current_user).find_by club_id: params[:id]
    unless correct_manager
      flash[:danger] = t "not_correct_manager"
      redirect_to club_manager_path
    end
  end
end
