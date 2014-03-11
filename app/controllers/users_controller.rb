# encoding: utf-8
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: [:index, :destroy]
  helper_method :sort_column, :sort_direction


  def index
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
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
    if current_user && current_user.admin?
      params.require(:user).permit(:name, :family_name, :admin, :email, :birthdate, :password, :password_confirmation, :avatar, :terms_of_service, :nif)
    else
      params.require(:user).permit(:name, :family_name, :email, :birthdate, :password, :password_confirmation, :avatar, :terms_of_service, :nif)
    end
  end

  # Before filters
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless (current_user?(@user) || current_user.admin?)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "family_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
