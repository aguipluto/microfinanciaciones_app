class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  http_basic_authenticate_with :name => 'teo', :password => 'teo' if Rails.env.production?

  def render_not_found(exception)
    render :template => "/errors/404.html.erb",
           :layout => 'errors.html.erb'
  end

  def render_error(exception)
    ExceptionNotifier::Notifier
    .exception_notification(request.env, exception)
    .deliver
    render :template => "/errors/500.html.erb",
           :layout => 'errors.html.erb'
  end
end
