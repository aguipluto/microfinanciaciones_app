# encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.confirmed?
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_back_or root_url+'#colabora'
      else
        flash.now[:danger] = 'Usuario y/o contraseña no correctos'
        render 'new'
      end
    elsif user
      UserMailer.confirmation_email(user).deliver!
      flash.now[:danger] = 'Email pendiente de confirmación. Por favor, revise su bandeja de entrada.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
