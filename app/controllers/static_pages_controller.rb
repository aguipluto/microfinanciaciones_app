class StaticPagesController < ApplicationController
  #http_basic_authenticate_with :name => "teodoro", :password => "teodoro"
  caches_action :home, :layout => false

  def home
    @proyectos = Proyecto.aportables
  end

  def help
  end

  def about
  end

  def contact
  end
end
