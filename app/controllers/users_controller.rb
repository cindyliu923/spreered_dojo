class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
  end
  def edit
  end
  def update
    if @user.update!(user_params)
      flash[:notice] = '更新成功'
      redirect_to user_path(@user)
    else
      flash[:alert] = '更新失敗'
      render edit_user_path(@user)
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name,:description,:avatar)
  end
end
