class TimeLineHomesController < ApplicationController
  def index
    @clubs = current_user.clubs
  end
end
