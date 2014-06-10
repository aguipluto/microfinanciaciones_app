class StaticPagesController < ApplicationController

  def home
    if params[:tag]
      @proyectos = Proyecto.aportables.tagged_with(params[:tag])
    else
      @proyectos = Proyecto.aportables
    end
    respond_to do |format|
      format.html
      format.js
    end
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
