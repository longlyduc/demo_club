class ClubManager::ImagesController < ApplicationController
  before_action :load_image, except: :create
  before_action :user_signed_in

  def create
    image = Image.new image_params
    if image.save
      flash[:success] = t "club_manager.image.success_create"
      redirect_to club_manager_club_album_path id: image.album_id
    else
      flash_error image
      redirect_to club_manager_club_album_path id: image.album_id
    end
  end

  def destroy
    if @image.destroy
      flash[:success] = t "club_manager.image.deleted"
    else
      flash[:danger] = t "club_manager.image.cant_delete"
    end
    redirect_to club_manager_club_album_path id: params[:album_id]
  end

  private

  def image_params
    params.require(:image).permit :name, :url, :user_id, :album_id
  end

  def load_image
    @image = Image.find_by id: params[:id]
    unless @image
      flash[:danger] = t "not_found_album"
      redirect_to root_url
    end
  end
end
