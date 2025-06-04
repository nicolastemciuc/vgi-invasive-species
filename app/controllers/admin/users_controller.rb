class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to admin_users_path, alert: "You cannot delete yourself."
    else
      @user.destroy
      redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
