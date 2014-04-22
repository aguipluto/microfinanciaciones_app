class PasswordRessetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_token if user
    flash[:success] = "Email enviado con las instrucciones para recuperar contraseña."
    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_send < 2.hours.ago
      flash[:warning] = "El link ha caducado. Vuelva a solicitar cambio de contraseña."
      redirect_to new_password_resset_path
    elsif @user.update_attributes(password_params)
      flash[:success] = "Contraseña cambiada correctamente"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
