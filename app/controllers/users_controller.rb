class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]
  before_action :set_user, except: %i[index]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Usuário excluido com sucesso."
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :avatar_image, :role, :password)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
