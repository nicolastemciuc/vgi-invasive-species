class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def edit
    @user_roles = User.roles.keys.map { |r| [ r.titleize, r ] }
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
      redirect_to admin_users_path, alert: "No puedes borrarte a ti misme."
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
    params.expect(user: [ :email, :role ])
  end
end
