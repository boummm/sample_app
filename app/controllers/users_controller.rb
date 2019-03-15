class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path
    flash[:danger] = t("controllers.users.create.find")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t("controllers.users.create.welcome")
      redirect_to @user
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation, :gender, :date_of_birth)
  end
end
