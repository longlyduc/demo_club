class BaseClubManagerController < ApplicationController
  layout "club_manager_layout"

  before_action :user_signed_in
  before_action :manager_verify

  protected
  def manager_verify
    @managers = current_user.user_clubs.manager
    unless @managers.any?
      flash[:danger] = t("manager_require")
      redirect_to root_path
    end
  end

  def correct_manager
    correct_manager = manager_of_club(current_user).find_by club_id: params[:club_id]
    unless correct_manager
      flash[:danger] = t "not_correct_manager"
      redirect_to club_manager_path
    end
  end

  def load_correct_member
    correct_member = @member.user_clubs.find_by club_id: params[:club_id]
    unless correct_member
      flash[:danger] = t("user.cant_found")
      redirect_to club_manager_club_members_path params[:club_id]
    end
  end
end
