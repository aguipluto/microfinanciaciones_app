# encoding: utf-8
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update, :show, :aportations, :delete]
  before_action :admin_user, only: [:index, :destroy, :adm_confirm]

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
    @user.confirmation_code = SecureRandom.urlsafe_base64
    if @user.save
      #TODO descomentar para enviar email de confirmación
      UserMailer.confirmation_email(@user).deliver!
      flash[:success] = "Revise su bandeja de entrada para completar el registro!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def send_forget_email

  end

  def edit
  end

  def aportations
    @user = User.find(params[:id])
    @aportations = User.find(params[:id]).cart_items_purchased.paginate(page: params[:page], per_page: 10)
    @volunteers = current_user.volunteers.paginate(page: params[:page_volunteers], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def adm_confirm
    @user = User.find(params[:id])
    @user.update_attribute(:confirmed, true)

  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirmation_code.== params[:confirmation_code]
      @user.update_attribute(:confirmed, true)
      flash[:success] = "Email confirmado. Bienvenido a las Microfinanciaciones!"
    else
      flash[:warning] = "Ha ocurrido un error. Por favor, intente de nuevo"
    end
    redirect_to root_url
  end

  def update
    @user = User.find(params[:id])
    #TODO al modificar el email que tb se envíe email de confirmación ?? OBSERVER
    if @user.update_attributes(user_params)
      flash[:success] = "Datos de Usuario actualizados"
      redirect_to @user
    else
      flash[:warning] = "No se han podido cambiar los datos. Por favor, intente de nuevo."
      render 'show'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
  end

  def delete
    @user = User.find(params[:id])
    @user.update_attribute(:email, @user.id.to_s + '-' + @user.email)
    @user.update_attribute(:uid, nil)
    @user.carts.each do |c|
      c.deleted_user
    end
    @user.blog_posts.each do |bp|
      bp.deleted_user
    end
    @user.update_attribute(:deleted, true)
    if current_user?(@user)
      sign_out
      redirect_to root_url
    else
      respond_to do |format|
        format.html do
          flash[:success] = "Usuario borrado."
          redirect_to users_url
        end
        format.js
      end
    end
  end

  private

  def user_params
    if current_user && current_user.admin?
      params.require(:user).permit(:name, :family_name, :admin, :blog_editor, :email, :birthdate, :password, :password_confirmation, :avatar, :terms_of_service, :nif, :image)
    else
      params.require(:user).permit(:name, :family_name, :email, :birthdate, :password, :password_confirmation, :avatar, :terms_of_service, :nif, :image)
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
