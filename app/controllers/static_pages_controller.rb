class StaticPagesController < ApplicationController
  #http_basic_authenticate_with :name => "teodoro", :password => "teodoro"

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
