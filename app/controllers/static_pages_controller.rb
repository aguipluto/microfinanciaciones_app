class StaticPagesController < ApplicationController

  def home
    @proyectos = Proyecto.aportables
  end

  def help
  end

  def about
  end

  def contact
  end

  def legal
  end
end
