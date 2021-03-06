class VolunteersController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user, only: [:index, :update, :show]

  def create
    @proyecto = Proyecto.find(params[:volunteer][:proyecto_id])
    current_user.make_volunteer!(@proyecto)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def update
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update_attributes(volunteers_params)
      respond_to do |format|
        format.html { redirect_to volunteers_path }
        format.js
      end
    end
  end

  def send_answer
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update_attributes(volunteers_params)
      VolunteerMailer.answer_email(@volunteer).deliver!
      respond_to do |format|
        format.html { redirect_to volunteers_path }
        format.js
      end
    else
      render 'volunteers'
    end
  end

  def show
    @volunteer = Volunteer.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @volunteer.user }
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
  def volunteers_params
    params.require(:volunteer).permit(:status, :answer)
  end

  def sort_column
    %w[users.family_name proyectos.titulo volunteers.created_at users.birthdate users.email].include?(params[:sort]) ? params[:sort] : "volunteers.created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
