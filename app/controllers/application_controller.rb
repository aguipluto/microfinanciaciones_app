class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :sort_column, :sort_direction
  protect_from_forgery with: :exception
  include SessionsHelper
  http_basic_authenticate_with :name => 'teo.rojo@ceu.es', :password => 'teo' if Rails.env.production?
end
