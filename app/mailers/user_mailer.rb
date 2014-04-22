class UserMailer < ActionMailer::Base
  default from: "noreply@microfinanciacionesceu.com"

  def confirmation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenido a las microfinanciaciones')
  end

  def password_reset_email(user)
    @user = user
    mail(to: @user.email, subject: 'Reestablecer contraseña')
  end
end
