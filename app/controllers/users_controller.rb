# encoding: utf-8
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: :destroy


  def index
    @users = User.paginate(page: params[:page], per_page: 50)
  end

  def show
    @user = User.find(params[:id])
    @purchased_carts = @user.purchased_carts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenido a las MicroAportaciones!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Datos de Usuario actualizados"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario borrado."
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :family_name, :email, :birthdate, :password, :password_confirmation, :avatar)
  end

  # Before filters
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
