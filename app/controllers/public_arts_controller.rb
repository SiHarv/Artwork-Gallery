class PublicArtsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_art, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]

    def index
    @arts = @user.arts
  end

  def show
    # @art is set by the set_art callback
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_art
    @art = @user.arts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to public_arts_path(@user), alert: "Art not found."
  end
end
