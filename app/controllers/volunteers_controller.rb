class VolunteersController < ApplicationController
  before_action :signed_in_user

  def create
    @proyecto = Proyecto.find(params[:volunteer][:proyecto_id])
    current_user.make_volunteer!(@proyecto)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @proyecto = Volunteer.find(params[:id]).proyecto
    current_user.not_volunteer!(@proyecto)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def index
    @volunteers = Volunteer.includes(:user, :proyecto).search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def sort_column
    %w[users.family_name proyectos.titulo volunteers.created_at users.birthdate users.email].include?(params[:sort]) ? params[:sort] : "volunteers.created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
